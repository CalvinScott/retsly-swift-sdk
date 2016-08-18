//
//  Client.swift
//  retsly-swift-sdk
//
//  Created by Calvin Scott on 2016-08-16.
//  Copyright © 2016 Calvin Scott. All rights reserved.
//

import Foundation // do I need this?

public class Client {
    let BASE_URL = "https://rets.io/api/v1"
    var vendor: String
    var token: String
    var resource: String

    /**
     * Retsly API Client
     * @param String token
     * @param String vendor
     * @return Retsly/Client
     */

    init(token: String, vendor: String, resource: String) {
        self.vendor = vendor
        self.token = token
        self.resource = resource
        /* */
    }

    func create(token: String, vendor: String, resource: String) -> Client {
        return Client(token: token, vendor: vendor, resource: resource)
    }

    /**
     * Set the vendor
     * @param String vendor
     */

    func vendor(vendor: String) {
        self.vendor = vendor
    }

    func resource(resource: String) {
        self.resource = resource
    }

    /**
     * Set the vendor
     * @param String vendor
     */

    func initRequest(query: [String: String]) -> Request {
        let reqObj = Request.init(client: self, token: self.token, vendor: self.vendor, resource: "listings", method: "GET", url: self.getURL(self.resource, vendor: self.vendor), query: query)
        return reqObj
    }

    /*
     * Gets a URL for the given resource and vendor. TODO: Make this a private function as it should not be used outside of Client/Request
     * @param String resource
     * @param String vendor
     * @return String url
     */

    func getURL(resource: String, vendor: String) -> String {
        return "\(self.BASE_URL)/\(vendor)/\(resource)/"
    }

    /**
     * Setup a ListingRequest Instance
     * @param Dictionary query
     * @return Retsly/Request
     */

    func listings(query: [String: String]) -> ListingRequest {
        let listingReq = ListingRequest.init(client: self, query: query)
        return listingReq
    }

    /**
     * Setup a ListingRequest Instance
     * @param Dictionary query
     * @return Retsly/Request
     */

    func agents(query: [String: String]) -> AgentRequest {
        let agentReq = AgentRequest.init(client: self, query: query)
        return agentReq
    }

    /**
     * Setup a ListingRequest Instance
     * @param Dictionary query
     * @return Retsly/Request
     */

    func offices(query: [String: String]) -> OfficeRequest {
        let officeReq = OfficeRequest.init(client: self, query: query)
        return officeReq
    }

    /**
     * Setup a ListingRequest Instance
     * @param Dictionary query
     * @return Retsly/Request
     */

    func openHouses(query: [String: String]) -> OpenHouseRequest {
        let openHouseReq = OpenHouseRequest.init(client: self, query: query)
        return openHouseReq
    }

    /**
     * Setup a ListingRequest Instance
     * @param Dictionary query
     * @return Retsly/Request
     */

    func assessments(query: [String: String]) -> AssessmentRequest {
        let assessmentReq = AssessmentRequest.init(client: self, query: query)
        return assessmentReq
    }

    /**
     * Setup a ListingRequest Instance
     * @param Dictionary query
     * @return Retsly/Request
     */

    func transactions(query: [String: String]) -> TransactionRequest {
        let transactionReq = TransactionRequest.init(client: self, query: query)
        return transactionReq
    }

    /**
     * Setup a ListingRequest Instance
     * @param Dictionary query
     * @return Retsly/Request
     */

    func parcels(query: [String: String]) -> ParcelRequest {
        let parcelReq = ParcelRequest.init(client: self, query: query)
        return parcelReq
    }
}
