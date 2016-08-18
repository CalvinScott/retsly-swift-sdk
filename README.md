
# swift-sdk

[Retsly](https://rets.ly/) Swift language SDK. Requires Swift 2.2

## Install

Drop the Retsly folder in your XCode file project, or somewhere in your Swift project directory.

## Usage

The most basic usage is described in the following code block:

```swift

// Place this near the top of your ViewController
// Don't worry about too much about setting the vendor and resource, they can be changed later
let Retsly = Client(token: "token", vendor: "test", resource: "listings");

// Initialize a Request class
let retslyRequest = Retsly.initRequest(query) // this will build off of the Client
retslyRequest.makeRequest() {
  data in
  // Do stuff with data
}
```

## API

### Client(token: String, vendor: String, resource: String)

A new instance of `Client` needs an API token and a vendor. If you are unsure of which vendor and resource to use, it is best to start with `'test'` and `'listings'`.

### Client.vendor(vendor: String)

Sets the vendor to the given value.

### Client.resource(resource: String)

Sets the resource to the given value.

### Client.initRequest(query: [String: String])

Returns a new `Request` with the Client defined vendor and resource.
If you're unsure what to use as a query when starting, ["limit": "100"] is a good basic default query.

### Client.listings(query: [String: String])

Returns a new `Request` for the Listings resource.

### Client.agents(query: [String: String])

Returns a new `Request` for the Agents resource.

### Client.offices(query: [String: String])

Returns a new `Request` for the Offices resource.

### Client.openHouses(query: [String: String])

Returns a new `Request` for the OpenHouses resource.

### Client.assessments(query: [String: String])

Returns a new `Request` for the Assessments resource.

### Client#transactions(query: [String: String])

Returns a new `Request` for the Transactions resource.

### Client#parcels(query: [String: String])

Returns a new `Request` for the Parcels resource.

### Request(client: Client, token: String, vendor: String, resource: String, method: String, url: String, query: [String: String])

The request initializer takes an instance of a Client, a token, the vendor and resource you wish to query (same as with Client), a HTTP method, a complete URL, and a Dictionary representing the query string. `Request` instances are normally provided by a `Client`.

### Request.addToQuery(query: [String: String])

Adds the dictionary `query` to the query string. You can call this as many times as you like. Queries should be formatted in the following way:
["field[op]": "value"] where op is defaulted to "eq", but can any of "eq", "ne", "lt", "gt", "lte", "gte".

E.g. To add a price query to a request:

```
// Query houses with prices greater than 1000000
Request.addToQuery(["price[gt]": "1000000"])
```

TODO: Allow actual boolean operators, such as ">". For now, this behaviour can be used in set().

### Request.set(field: String, op: String, value: String)

Much like addToQuery() but with easier to access syntax. Adds to the query with the parameters supplied.

```
// Query houses with prices greater than 1000000
E.g. `Request.set("price", op: ">", value: "1000000")
```

### Request.addLimit(limit: String)

Adds a limit restriction on to the query, determining how many documents you would like returned.
Alias for `Request.addToQuery(["limit": "value"])`.

### Request.addOffset(offset: String)

Alias for `Request.addToQuery(["offset": "value"])`.

### Request.getById(resource: String, id: String, callback: (response: NSDictionary) -> Void)

Get a single document by its id (`id`).

### Request.getAll(query: [String: String], callback: (response: NSDictionary) -> Void)

Get a collection of documents according to the query.

### Request.findAll(query: [String: String], callback: (response: NSDictionary) -> Void)

Alias for `Request.getAll()`.

### Request.findOne(query: [String: String], callback: (response: NSDictionary) -> Void)

Get only a single document from the given query.

### Request.makeRequest(callback: (response: NSDictionary) -> Void)

Makes the actual HTTP request to the Retsly API. Will use the currently built url on the Request class according to query parameters given.

## License

(The MIT License)

Copyright (c) 2016 Retsly Software Inc. <support@rets.ly>

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the 'Software'), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED 'AS IS', WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
