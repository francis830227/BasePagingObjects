//
//  BaseViewController.swift
//  BaseViewObjects
//
//  Created by Kai-Ping Tseng on 2020/2/14.
//  Copyright © 2020 Francis. All rights reserved.
//

import UIKit

//class BaseViewController: UIViewController, NeedPanNavigationDelegate {
class BaseViewController: UIViewController, NeedPanTransitioningDelegate {
    
//    var navigationDelegate = PanNavigationDelegate()
    var panTransitioningDelegate = PanTransitioningDelegate()
    
    var collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
        
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupCollectionView()
        
        
//        let vc = RightViewController()
//        setupNavigationDelegate(with: vc)
        
        let vc = UINavigationController(rootViewController: RightViewController())
        setupTransitioningDelegate(with: vc)
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: true)
    }
    
    func setupCollectionView() {
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
        collectionView.backgroundColor = .white
        collectionView.frame = view.bounds
        collectionView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.isPagingEnabled = true
        collectionView.register(DemoCollectionViewCell.self, forCellWithReuseIdentifier: "cell")
        collectionView.contentInsetAdjustmentBehavior = .never
        view.addSubview(collectionView)
    }

}


