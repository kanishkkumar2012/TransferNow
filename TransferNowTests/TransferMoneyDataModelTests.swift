//
//  TransferMoneyDataModelTests.swift
//  TransferNowTests
//
//  Created by Kanishk KUMAR on 11/6/18.
//  Copyright © 2018 Kanishk KUMAR. All rights reserved.
//

import Foundation
import Quick
import Nimble
@testable import TransferNow

class TransferMoneyDataModelTests: QuickSpec {

    override func spec() {
        let transferMoneyDataModel = TransferMoneyDataModel(success: true, amount: "100", currency: "hkd")

        describe("Verify TransferMoneyDataModel model's attributes") {
            context("when initialized with valid data", closure: {

                it("should have a valid amount to transfer", closure: {
                    expect(transferMoneyDataModel.amount) == "100"
                })

                it("should have success", closure: {
                    expect(transferMoneyDataModel.success) == true
                })

                it("should have correct currency", closure: {
                    expect(transferMoneyDataModel.currency) == "hkd"
                })
            })
        }
    }
}
