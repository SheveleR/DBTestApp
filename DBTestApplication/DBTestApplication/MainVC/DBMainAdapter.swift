//
//  DBMainAdapter.swift
//  DBTestApplication
//
//  Created by SheveleR on 05/03/2018.
//  Copyright © 2018 SheveleR. All rights reserved.
//

import Foundation
import UIKit

class DBMainAdapter:NSObject, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    let reuseIdentifier = "collectionViewCell"
    fileprivate var _content: Array<DBMainCollectionViewContent>! = Array<DBMainCollectionViewContent>()
    var content: Array<DBMainCollectionViewContent>! {
        set(newValue) {
            _content = newValue
            self.collectionView.reloadData()
        }
        get {
            return _content
        }
    }
    var collectionView: UICollectionView!
    
    init(_ collectionView: UICollectionView) {
        super.init()
        self.collectionView = collectionView
        collectionView.dataSource = self
        collectionView.delegate = self
        onStart()
    }
    
    func onStart() {
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsetsMake(0, 0, 0, 0)
        collectionView.setCollectionViewLayout(layout, animated: false)
        collectionView.register(UINib.init(nibName: "DBMainContentCell", bundle: nil), forCellWithReuseIdentifier: reuseIdentifier)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return content.count
    }

    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath as IndexPath) as! DBMainContentCell
      
        cell.initUI(content[indexPath.row])
        return cell
    }
    
    // Отображаемая ячейка должна быть шириной в экран и не больше чем половина высоты экрана
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        var height: CGFloat = 100.0
        if let image = content[indexPath.row].shotImage {
            if image.size.height > UIScreen.main.bounds.height / 2 {
                height = UIScreen.main.bounds.height / 2
            }
            else {
                height = image.size.height
            }
        }
        return CGSize(width: UIScreen.main.bounds.width, height: height)
    }
}
