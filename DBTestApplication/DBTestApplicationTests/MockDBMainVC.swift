//
//  MockDBMainVC.swift
//  DBTestApplicationTests
//
//  Created by SheveleR on 09/03/2018.
//  Copyright © 2018 SheveleR. All rights reserved.
//

import Foundation
import XCTest
import Mockit
@testable import DBTestApplication

class MockDBMainVC: DBMainVCProtocol, Mock {
    
    var offerTappedBlock: (() -> Void)?
    let callHandler: CallHandler
    init (_ testCase: XCTestCase) {
        callHandler = CallHandlerImpl(withTestCase: testCase)
    }

    func instanceType() -> MockDBMainVC {
        return self
    }
    func updateAdapter(_ collectionViewContent: Array<DBMainCollectionViewContent>) {
        let _ = callHandler.accept(nil, ofFunction: #function, atFile: #file, inLine: #line, withArgs: collectionViewContent)
    }
    func showError(_ error: SimpleCustomError) {
        let _ = callHandler.accept(nil, ofFunction: #function, atFile: #file, inLine: #line, withArgs: error)
    }
}
