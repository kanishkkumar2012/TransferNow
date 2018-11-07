//
//  TransferNowTests.swift
//  TransferNowTests
//
//  Created by Kanishk KUMAR on 10/30/18.
//  Copyright © 2018 Kanishk KUMAR. All rights reserved.
//

import XCTest
import Quick
import Nimble
@testable import TransferNow

class ServiceAPIEndPoint: QuickSpec {

    var apiManager = APIManager.self
    override func spec() {
        describe("Verify APIManager") {
            context("when initialized", closure: {
                it("should have correct env as development", closure: {
                    expect(self.apiManager.environment) == APIEnvironment.development
                })
            })

            context("when service request returns success for money transfer", closure: {
                fit("should be successfull", closure: {
                    let apiManager = self.apiManager.init()
                    var responseObject: TransferMoneyDataModel?
                    apiManager.initMoneyTransfer(amount: 100, fromAccountNumber: 1000, toAccountNumber: 10000, completion: { (apiResponse, error) in
                        responseObject = apiResponse?[0]
                    })
                    expect(responseObject?.amount).toEventually(equal("100"))
                    expect(responseObject?.success).toEventually(beTrue())
                    expect(responseObject?.currency).toEventually(equal("hkd"))
                })
            })
        }
    }
}
