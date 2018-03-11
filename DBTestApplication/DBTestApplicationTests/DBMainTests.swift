//
//  DBMainTests.swift
//  DBTestApplicationTests
//
//  Created by SheveleR on 09/03/2018.
//  Copyright © 2018 SheveleR. All rights reserved.
//

import XCTest
import RealmSwift
@testable import DBTestApplication

class DBMainTests: XCTestCase {
    let defaultURl: URL! = URL.init(string: "https://api.dribbble.com/v1/shots?page=1&per_page=100&access_token=5e7d0636d454c2265767c39077d60b0304f4940103e19ea96b7f387cc903e8c0")
    let normalImageUrl: URL! = URL.init(string: "https://d13yacurqjgara.cloudfront.net/users/1/screenshots/471756/sasquatch.png")
    var mainVC: DBMainVC!
    var mainPresenter: DBMainPresenter!
    var model: DBMainModel!
    override func setUp() {
        super.setUp()
    }
    
    func testInitDBMainVC() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc: DBMainVC = storyboard.instantiateViewController(withIdentifier: "DBMainVC") as! DBMainVC
        mainVC = vc
        
        _ = mainVC.view // To call viewDidLoad
        XCTAssertTrue(mainVC.mainAdapter != nil)
        XCTAssertTrue(mainVC.mainPresenter != nil)
        XCTAssertTrue(mainVC.collectionView != nil)
        XCTAssertTrue(mainVC.refresher != nil)
        mainPresenter = DBMainPresenter.init(mainVC, DBMainModel())
        XCTAssertTrue(mainPresenter.collectionViewContent.count == 0)
        XCTAssertTrue(mainPresenter.model != nil)
        XCTAssertTrue(mainPresenter.view != nil)
    }
}
