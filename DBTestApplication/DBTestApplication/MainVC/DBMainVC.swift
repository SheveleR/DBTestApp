//
//  DBMainVC.swift
//  DBTestApplication
//
//  Created by SheveleR on 03/03/2018.
//  Copyright © 2018 SheveleR. All rights reserved.
//

import UIKit
import RealmSwift

class DBMainVC: UIViewController, DBMainVCProtocol {
    let kMaxShots: Int = 50
    var mainAdapter: DBMainAdapter!
    
    @IBOutlet weak var collectionView: UICollectionView!
    var mainPresenter: DBMainPresenterProtocol!
    var refresher:UIRefreshControl!
    
    // при загрузке инитим адаптер-презентер-ui
    override func viewDidLoad() {
        super.viewDidLoad()
        initAdapter()
        initBack()
        initUI()
    }

    func initBack() {
        mainPresenter = DBMainPresenter.init(self, DBMainModel())
    }
    
    func initAdapter() {
        mainAdapter = DBMainAdapter.init(self.collectionView)
    }
    
    // Добавляем pullFefresh и collectionView
    func initUI() {
        self.refresher = UIRefreshControl()
        self.collectionView!.alwaysBounceVertical = true
        self.refresher.tintColor = UIColor.red
        self.refresher.addTarget(self, action: #selector(pullRefresh), for: .valueChanged)
        self.collectionView!.addSubview(refresher)
    }
    
    // Обновляем контент адаптера
    func updateAdapter(_ collectionViewContent: Array<DBMainCollectionViewContent>) {
        mainAdapter.content = collectionViewContent
        if refresher != nil && refresher.isRefreshing && collectionViewContent.count == kMaxShots {
            refresher.endRefreshing()
            self.collectionView.setNeedsLayout()
            self.collectionView.layoutIfNeeded()
        }
    }
    
    // Пользователь сделал pullRefresh
    @objc func pullRefresh() {
        mainPresenter.pullRefresh()
    }
    
    // Показываем ошибку
    func showError(_ error: SimpleCustomError) {
        let alert = UIAlertController(title: "Ошибка", message: error.errorMsg, preferredStyle: .alert)
        
        alert.addAction(UIAlertAction.init(title: "Далее", style: .default, handler: { (action) in
            self.hidePullRefresh()
        }))
        self.present(alert, animated: true, completion: nil)
    }
    
    // Хайдим pullRefresh
    func hidePullRefresh() {
        if refresher != nil && refresher.isRefreshing {
            refresher.endRefreshing()
        }
    }
    
}

