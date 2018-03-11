//
//  DBTestApplicationTests.swift
//  DBTestApplicationTests
//
//  Created by SheveleR on 03/03/2018.
//  Copyright © 2018 SheveleR. All rights reserved.
//

import XCTest
import Mockit
import RealmSwift

@testable import DBTestApplication

class RCLoanApplicationConfigurationsStep1Tests: XCTestCase {
//    var responseString: String = "{\r\n\t\"id\": 4322082,\r\n\t\"title\": \"Food app - Map & AR\",\r\n\t\"images\": {\r\n\t\t\"hidpi\": \"https://cdn.dribbble.com/users/1493956/screenshots/4322082/food_app_-_ar.png\",\r\n\t\t\"teaser\": \"https://cdn.dribbble.com/users/1493956/screenshots/4322082/food_app_-_ar_teaser.png\",\r\n\t\t\"normal\": \"https://cdn.dribbble.com/users/1493956/screenshots/4322082/food_app_-_ar_1x.png\"\r\n\t},\r\n\t\"description\": \"I had an idea about a food application that allows the user to search and find\"\r\n}" // Maybe for other cases

    var presenter: DBMainPresenter!
    var mockVC: MockDBMainVC!
    var mockModel: MockDBMainModel!
    var getShotBlock: ((Bool, SimpleCustomError?)->Void)?
    
    override func setUp() {
        super.setUp()
        mockVC = MockDBMainVC.init(self)
        mockModel = MockDBMainModel.init(testCase: self)
        presenter = DBMainPresenter.init(mockVC, mockModel)
    }

    func testOnStartNoError() {
        let collectionViewContentArray = Array<DBMainCollectionViewContent>()
        let getShotBlock = presenter.getShotsBlock!
        mockModel.when().call(withReturnValue: mockModel.loadShots(isPullRefresh: true, getShotBlock), andArgumentMatching: [Anything()]).thenDo { (res: [Any?]) in
            getShotBlock(true, nil)
        }
        
        presenter.onStart()

        mockModel.verify(verificationMode: Times.init(times: 2)).loadShots(isPullRefresh: true, getShotBlock)
        mockVC.verify(verificationMode: Once()).updateAdapter(collectionViewContentArray)
    }
    
    func testOnStartRequestError() {
        let error = SimpleCustomError(withErrorLocalizedString: "It's a trap!")	
        let getShotBlock = presenter.getShotsBlock!
        mockModel.when().call(withReturnValue: mockModel.loadShots(isPullRefresh: true, getShotBlock), andArgumentMatching: [Anything()]).thenDo { (res: [Any?]) in
            getShotBlock(false, error)
        }
        
        presenter.onStart()
        
        mockModel.verify(verificationMode: Times.init(times: 2)).loadShots(isPullRefresh: true, getShotBlock)
        mockVC.verify(verificationMode: Once()).showError(error)
    }
}
