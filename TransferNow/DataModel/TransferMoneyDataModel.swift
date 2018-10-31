//
//  DataAPIResponse.swift
//  TransferNow
//
//  Created by Kanishk KUMAR on 10/31/18.
//  Copyright © 2018 Kanishk KUMAR. All rights reserved.
//

import Foundation

/// TransferMoney Data Model
struct TransferMoneyDataModel {
    let success: String
    let amount: String
    let currency: String
}

// MARK: - TransferMoney Extension
extension TransferMoneyDataModel: Decodable {
    
    enum TransferMoneyCodingKeys: String, CodingKey {
        case success
        case amount
        case currency
    }
    
    init(from decoder: Decoder) throws {
        let transferMoneyContainer = try decoder.container(keyedBy: TransferMoneyCodingKeys.self)
        success = try transferMoneyContainer.decode(String.self, forKey: .success)
        amount = try transferMoneyContainer.decode(String.self, forKey: .amount)
        currency = try transferMoneyContainer.decode(String.self, forKey: .currency)
    }
}
