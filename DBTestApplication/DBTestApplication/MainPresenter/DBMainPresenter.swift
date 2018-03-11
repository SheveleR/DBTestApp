//
//  DBMainPresenter.swift
//  DBTestApplication
//
//  Created by SheveleR on 05/03/2018.
//  Copyright © 2018 SheveleR. All rights reserved.
//

import Foundation
import RealmSwift

class DBMainPresenter: DBMainPresenterProtocol {
    var view: DBMainVCProtocol!
    var model: DBMainModelProtocol!
    var realmContent: Array<DBShotObject> = Array<DBShotObject>()
    var collectionViewContent: Array<DBMainCollectionViewContent> = Array<DBMainCollectionViewContent>()
    
    var getShotsBlock: ((Bool, SimpleCustomError?)-> Void)?
    
    required init(_ viewControlelr: DBMainVCProtocol, _ model: DBMainModelProtocol) {
        self.view = viewControlelr
        self.model = model
        self.getShotsBlock = { (isOkay, err) in
            if let error = err {
                self.showAlert(error)
            }
            else if isOkay {
                self.getContentFromRealm()
            }
        }
        onStart()
    }
    
    // При запуске презентера дергаем модель и загружаем контент
    func onStart() {
        model.loadShots(isPullRefresh: false, getShotsBlock!)
    }
    
    // Дергаем модель при pullRefresh
    func pullRefresh() {
        model.loadShots(isPullRefresh: true, getShotsBlock!)
    }
    
    
    // Конвертим данные модели под данные для отображения и дергаем вьюху
    func getContentFromRealm() {
        var content = Array<DBMainCollectionViewContent>()
        let realmContent = try! Realm().objects(DBShotObject.self)
        for item in realmContent {
            let contentDesc = DBMainCollectionViewContent.init(item.stringName, item.stringDescription, item.shotImageData)
            content.append(contentDesc)
        }
        view.updateAdapter(content)
    }
    
    func showAlert(_ error: SimpleCustomError) {
        view.showError(error)
    }
}
