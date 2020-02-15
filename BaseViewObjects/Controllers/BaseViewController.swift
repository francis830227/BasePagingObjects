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
        view.addSubview(collectionView)
    }

}

extension BaseViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 5
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as? DemoCollectionViewCell else { return UICollectionViewCell() }
        
        cell.label.text = "\(indexPath.row)"
        
        return cell
    }
    
}

extension BaseViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return view.frame.size
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
}
