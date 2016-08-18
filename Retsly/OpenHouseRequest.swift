//
//  OpenHouseRequest.swift
//  retsly-swift-sdk
//
//  Created by Calvin Scott on 2016-08-17.
//  Copyright © 2016 Calvin Scott. All rights reserved.
//

import Foundation

class OpenHouseRequest: Request {
    init(client: Client, query: [String: String]) {
        super.init(client: client, token: client.token, vendor: client.vendor, resource: "openhouses", method: "GET", url: client.getURL("openhouses", vendor: client.vendor), query: query);
    }
}
