//
//  ListingRequest.swift
//  retsly-swift-sdk
//
//  Created by Calvin Scott on 2016-08-16.
//  Copyright © 2016 Calvin Scott. All rights reserved.
//

import Foundation

class ListingRequest: Request {
    init(client: Client, query: [String: String]) {
        super.init(client: client, token: client.token, vendor: client.vendor, resource: "listings", method: "GET", url: client.getURL("listings", vendor: client.vendor), query: query);
    }
}
