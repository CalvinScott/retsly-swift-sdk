//
//  ParcelRequest.swift
//  retsly-swift-sdk
//
//  Created by Calvin Scott on 2016-08-17.
//  Copyright © 2016 Calvin Scott. All rights reserved.
//

import Foundation

class ParcelRequest: Request {
    init(client: Client, query: [String: String]) {
        super.init(client: client, token: client.token, vendor: "pub", resource: "parcels", method: "get", url: client.getURL("parcels", vendor: "pub"), query: query);
    }
}
