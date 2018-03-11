//
//  DBMainContentCell.swift
//  DBTestApplication
//
//  Created by SheveleR on 05/03/2018.
//  Copyright © 2018 SheveleR. All rights reserved.
//

import Foundation
import UIKit
class DBMainContentCell: UICollectionViewCell {
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    
    func initUI(_ desc: DBMainCollectionViewContent) {
        layer.borderWidth = 1.0
        layer.borderColor = UIColor.black.cgColor
        
        imageView.image = desc.shotImage
        nameLabel.text = desc.nameString
        descriptionLabel.text = desc.descriptionString
    }
}
