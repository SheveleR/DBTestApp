//
//  MockDBMainModel.swift
//  DBTestApplicationTests
//
//  Created by SheveleR on 09/03/2018.
//  Copyright © 2018 SheveleR. All rights reserved.
//

import Foundation

import XCTest
import Mockit
@testable import DBTestApplication

class MockDBMainModel: DBMainModelProtocol, Mock {
    
    let callHandler: CallHandler
    
    init(testCase: XCTestCase) {
        callHandler = CallHandlerImpl(withTestCase: testCase)
    }
    func instanceType() -> MockDBMainModel {
        return self
    }
    func loadShots(isPullRefresh: Bool, _ callback: @escaping (Bool, SimpleCustomError?)->Void?) {
        let _ = callHandler.accept(nil, ofFunction: #function, atFile: #file, inLine: #line, withArgs: callback)
    }
}
//            func calulateLoanInsurances(request: RCCalculateLoanInsurancesRequest, completion: @escaping (RCCalculateLoanInsurancesResponse?, RCErrorResponse?) -> Void) {
//                        let _ = callHandler.accept(nil, ofFunction: #function, atFile: #file, inLine: #line, withArgs: request, completion)
//                }
//
//            func loanContractSignRegister(request: RCLoanContractSignRegisterRequest, completion: @escaping (RCLoanContractSignRegisterResponse?, RCErrorResponse?) -> Void) {
//                        let _ = callHandler.accept(nil, ofFunction: #function, atFile: #file, inLine: #line, withArgs: request, completion)
//                }
//            func loanContractSignOTP(request: RCLoanContractSignOTPRequest, completion: @escaping (RCLoanContractSignOTPResponse?, RCErrorResponse?) -> Void) {
//                        let _ = callHandler.accept(nil, ofFunction: #function, atFile: #file, inLine: #line, withArgs: request, completion)
//                }

