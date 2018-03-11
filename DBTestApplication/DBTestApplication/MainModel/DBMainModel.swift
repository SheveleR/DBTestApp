//
//  DBMainModel.swift
//  DBTestApplication
//
//  Created by SheveleR on 03/03/2018.
//  Copyright © 2018 SheveleR. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON
import Alamofire_SwiftyJSON
import RealmSwift
class SimpleCustomError: Error {
    var errorMsg: String?
    init(withErrorLocalizedString: String) {
        self.errorMsg = withErrorLocalizedString
    }
}
class DBMainModel: DBMainModelProtocol {
    let realm = try! Realm()
    let url: URL! = URL.init(string: "https://api.dribbble.com/v1/shots?page=1&per_page=100&access_token=5e7d0636d454c2265767c39077d60b0304f4940103e19ea96b7f387cc903e8c0") // Дефолтный url для загрузки первых 100 шотов
    
    // Входная функция, если Realm пустой или pullRefresh - загружаем новое, иначе берем из Realm
    func loadShots(isPullRefresh: Bool, _ callback: @escaping (Bool, SimpleCustomError?)->Void?) {
        if try! Realm().objects(DBShotObject.self).count > 0 && !isPullRefresh {
            callback(true, nil)
        }
        else {
            loadShotsFromDribble({ isOkay, err in
                callback(isOkay, err)
            })
        }
    }
    
    // Загрузка нового. Чистим Realm только в случае, если пришел ответ
    func loadShotsFromDribble(_ callback: @escaping (Bool, SimpleCustomError?)->Void?) {
        
        Alamofire.request(url, method: .get, parameters: nil, encoding: URLEncoding.default)
            .responseSwiftyJSON { dataResponse in
                    if let response = dataResponse.value {
                        try! self.realm.write {
                            self.realm.deleteAll()
                        }
                        for (_,subJson):(String, JSON) in response {
                            if let imageString = subJson["images"]["hidpi"].string, !imageString.isEmpty, !imageString.contains(".gif") {
                                self.asyncDownloadImage(imageString, subJson, callback)
                            }
                             if let imageString = subJson["images"]["normal"].string, !imageString.isEmpty, !imageString.contains(".gif")  {
                                self.asyncDownloadImage(imageString, subJson, callback)
                            }
                        }
                    }
                    else if let error = dataResponse.error {
                        callback(false, SimpleCustomError(withErrorLocalizedString: error.localizedDescription))
                    }
        }
    }
    
    //  По полученному URL загружаем данные картинки
    func asyncDownloadImage(_ imageString: String, _ subJSON: JSON, _ downloadCallback: @escaping (Bool, SimpleCustomError?)->Void?) {
        Alamofire.request((URL.init(string: imageString)!)).responseData(queue: DispatchQueue(label: "background",
                                                                                              qos: .utility,
                                                                                              attributes:.concurrent),
                                                                         completionHandler: { dataResponse in
            if let error = dataResponse.error  {
                downloadCallback(false, SimpleCustomError(withErrorLocalizedString: error.localizedDescription))
            }
            else if let data = dataResponse.result.value {
                DispatchQueue.main.async {
                    if self.realm.objects(DBShotObject.self).count < 50 {
                        self.addObjectToRealm(data, subJSON, downloadCallback)
                    }
                }
            }
        })
    }

    //  Добавляем объект в Realm и выстреливаем в presenter
    func addObjectToRealm(_ data: Data, _ subJSON: JSON, _ downloadCallback: (Bool, SimpleCustomError?)->Void?) {
        self.realm.beginWrite()
        let object = DBShotObject()
        object.shotId =  subJSON["id"].stringValue
        object.stringDescription =  subJSON["description"].stringValue.replacingOccurrences(of: "<[^>]+>", with: "", options: .regularExpression, range: nil)
        object.stringName =  subJSON["title"].stringValue
        object.shotImageData = data
        self.realm.add(object, update: true)
        try! self.realm.commitWrite()
        downloadCallback(true, nil)
    }
}
