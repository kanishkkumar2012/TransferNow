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
    var success: Bool
    var amount: String
    var currency: String
}

// MARK: - TransferMoney Extension
extension TransferMoneyDataModel: Decodable {
    
    enum TransferMoneyCodingKeys: String, CodingKey {
        case success = "success"
        case amount = "amount"
        case currency = "currency"
    }
    
    init(from decoder: Decoder) throws {
        let transferMoneyContainer = try decoder.container(keyedBy: TransferMoneyCodingKeys.self)
        success = try transferMoneyContainer.decode(Bool.self, forKey: .success)
        amount = try transferMoneyContainer.decode(String.self, forKey: .amount)
        currency = try transferMoneyContainer.decode(String.self, forKey: .currency)
    }
}
