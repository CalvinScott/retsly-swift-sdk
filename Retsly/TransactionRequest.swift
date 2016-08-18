//
//  TransactionRequest.swift
//  retsly-swift-sdk
//
//  Created by Calvin Scott on 2016-08-17.
//  Copyright © 2016 Calvin Scott. All rights reserved.
//

import Foundation

class TransactionRequest: Request {
    init(client: Client, query: [String: String]) {
        super.init(client: client, token: client.token, vendor: "pub", resource: "transactions", method: "GET", url: client.getURL("transactions", vendor: "pub"), query: query);
    }
}
