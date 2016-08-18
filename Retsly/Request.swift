//
//  Request.swift
//  retsly-swift-sdk
//
//  Created by Calvin Scott on 2016-08-16.
//  Copyright © 2016 Calvin Scott. All rights reserved.
//

import Foundation

// Overloaded + to allow merging two dictionaries
func + <K,V>(left: [K : V], right: [K : V]) -> [K : V] {
    var result = [K:V]()

    for (key,value) in left {
        result[key] = value
    }

    for (key,value) in right {
        result[key] = value
    }
    return result
}

class Request {
    var client: Client
    var method: String
    var url: String
    var query: [String: String]
    var limit: Int
    var offset: Int

    /**
     * Retsly API Request Client
     * @param String token
     * @param String vendor
     * @return Retsly/Request
     */

    init(client: Client, token: String, vendor: String, resource: String, method: String, url: String, query: [String: String]) {
        self.client = Client(token: token, vendor: vendor, resource: resource)
        self.method = method
        self.url = url
        self.query = query
        self.limit = 100
        self.offset = 0
    }

    /**
     * Add query to query string dictionary
     * @param NSDictionary query
     */

    func addToQuery(query: [String: String]) {
        self.query = self.query + query // uses the overloaded + operator as soon at the beginning of this file
        return
    }

    /**
     * Add query parameters to URL string
     * return String url
     * TODO: Make this private, as it should only be used internally
     */

    func queryParams() -> String {
        let query = self.query;
        var url = client.getURL(client.resource, vendor: client.vendor);
        url += "?"

        for (key, value) in query {
            url += "&" + key + "=" + value
        }

        self.url = url
        return url
    }

    func resetQuery() {
        self.url = self.client.getURL(self.client.resource, vendor: self.client.vendor)
    }

    /**
     * Add a customized constraint to the query string, i.e. price[lt]=600000
     * @param string field
     * @param string op
     * @param mixed value
     */

    func set(field: String, op: String, value: String) {
        var operation = op
        // Replace conditional operators with accepted string parameters
        if operation == "<" { operation = "lt" }
        if operation == ">" { operation = "gt" }
        if operation == "<=" { operation = "lte" }
        if operation == ">=" { operation = "gte" }
        if operation == "!=" { operation = "ne" }
        if operation == "="  { operation = "eq" }

        var q: [String: String]
        if operation == "eq" {
            q = [field: value]
        } else {
            let fieldOp = field + "[\(operation)]"
            q = [fieldOp: value]
        }

        self.addToQuery(q)
    }

    /**
     * Limit the response to val number of documents
     * @param String limit
     */

    func addLimit(limit: String) {
        self.addToQuery(["limit" : limit])
    }

    /**
     * Offset (skip) the response by a number of documents
     * @param String limit
     */

    func addOffset(offset: String) {
        self.addToQuery(["offset" : offset])
    }

    /**
     * Increases offset by one page (limit)
     */

    func nextPage() {
        self.offset = offset + limit
        self.addOffset("\(self.offset)")
    }

    /**
     * Decreases offset by one page (limit)
     */

    func prevPage() {
        self.offset = offset - limit
        self.addOffset("\(self.offset)")
    }

    /**
     * Starts a GET request for a single document by id
     * @param String resource
     * @param String id
     * @param Func<NSDictionary> -> Void callback
     * @return NSDictionary
     */

    func getById(resource: String, id: String, callback: (response: NSDictionary) -> Void) {
        self.method = "GET"
        var url = client.getURL(resource, vendor: client.vendor)
        url += id
        self.url = url
        return self.makeRequest(callback)
    }

    /**
     * Starts a GET request for an array of documents
     * @param Dictionary query
     * @param Func<NSDictionary> -> Void callback
     * @return NSDictionary
     */

    func getAll(query: [String: String], callback: (response: NSDictionary) -> Void) {
        self.method = "GET"
        if query.count > 0 {
            self.addToQuery(query)
        }
        return self.makeRequest(callback)
    }

    /**
     * Alias for getAll
     * @param Dictionary query
     * @param Func<NSDictionary> -> Void callback
     * @return NSDictionary
     */

    func findAll(query: [String: String], callback: (response: NSDictionary) -> Void) {
        return self.getAll(query, callback: callback)
    }

    /**
     * Starts a GET request for a single document
     * @param Dictionary query
     * @param Func<NSDictionary> -> Void callback
     * @return NSDictionary
     */

    func findOne(query: [String: String], callback: (response: NSDictionary) -> Void) {
        self.query["limit"] = "1"
        self.query["offset"] = "0"

        self.addToQuery(query)
        return self.makeRequest(callback)
    }

    /**
     * Sends the request and returns the result
     * @param Func<NSDictionary> -> Void
     * @return NSDictionary
     */

    func makeRequest(callback: (response: NSDictionary) -> Void) {
        // Create query string to appmakeRequest to URL
        let urlWithParams = queryParams()
        print("last", self.url)
        let myURL = NSURL(string: urlWithParams)
        if (myURL == nil) {
            let errDict = ["Error": "URL Problem"]
            return callback(response: errDict)
        }

        // Instantiate and modify the request object with Authorization Header
        let request = NSMutableURLRequest(URL: myURL!)
        request.HTTPMethod = self.method
        request.addValue("Bearer " + self.client.token, forHTTPHeaderField: "Authorization")

        // Setup HTTP Session
        let task = NSURLSession.sharedSession().dataTaskWithRequest(request) { data, response, error -> Void in
            if error != nil {
                // TODO: Do some kind of safe error handling/pass-off
                let errString = error!.localizedDescription
                let errDict = ["Error": errString]
                return callback(response: errDict)
            }

            // Convert JSON object into something usable by Swift
            do {
                if let convertedJsonIntoDict = try NSJSONSerialization.JSONObjectWithData(data!, options: []) as? NSDictionary {
                    callback(response: convertedJsonIntoDict)
                }
            } catch let error as NSError {
                print(error.localizedDescription)
                return
            }
        }
        // Run HTTP Session
        task.resume()
    }
}
