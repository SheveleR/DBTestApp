//
//  DBShotObject.swift
//  DBTestApplication
//
//  Created by SheveleR on 09/03/2018.
//  Copyright © 2018 SheveleR. All rights reserved.
//

import Foundation
import RealmSwift

class DBShotObject: Object {
    @objc dynamic var stringName: String? = ""
    @objc dynamic var stringDescription: String? = ""
    @objc dynamic var shotImageData: Data? = Data()
    @objc dynamic var shotId: String? = ""
    
    override static func primaryKey() -> String? {
        return "shotId"
    }
}
