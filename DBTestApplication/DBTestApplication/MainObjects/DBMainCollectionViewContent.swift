//
//  DBMainCollectionViewContent.swift
//  DBTestApplication
//
//  Created by SheveleR on 05/03/2018.
//  Copyright © 2018 SheveleR. All rights reserved.
//

import Foundation
import UIKit

class DBMainCollectionViewContent {
    var nameString: String?
    var descriptionString: String?
    var shotImage: UIImage?
    init(_ nameString: String?, _ descriptionString: String?, _ imageData: Data?) {
        if let name = nameString, !name.isEmpty {
            self.nameString = name
        }
        if let desc = descriptionString, !desc.isEmpty {
            self.descriptionString = desc
        }
        if let image = imageData {
            self.shotImage = UIImage.init(data: image)
        }
    }
}
