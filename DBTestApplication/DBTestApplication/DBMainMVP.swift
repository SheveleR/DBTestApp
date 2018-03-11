//
//  DBMainMVP.swift
//  DBTestApplication
//
//  Created by SheveleR on 05/03/2018.
//  Copyright © 2018 SheveleR. All rights reserved.
//

import Foundation
protocol DBMainVCProtocol {
    func updateAdapter(_ collectionViewContent: Array<DBMainCollectionViewContent>)
    func showError(_ error: SimpleCustomError)
}

protocol DBMainPresenterProtocol {
    init(_ viewController: DBMainVCProtocol, _ model: DBMainModelProtocol)
    func pullRefresh()
    func getContentFromRealm() 
}

protocol DBMainModelProtocol {
    func loadShots(isPullRefresh: Bool, _ callback: @escaping (Bool, SimpleCustomError?)->Void?)
}
