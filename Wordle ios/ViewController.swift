//
//  ViewController.swift
//  Wordle ios
//
//  Created by Muhammed Faruk Söğüt on 8.02.2022.
//

import UIKit

class ViewController: UIViewController {
    
    var collectionView : UICollectionView!

    override func viewDidLoad() {
        super.viewDidLoad()
        let layout = createFlowLayout()
        collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: layout)
        view.addSubview(collectionView)
        collectionView.dataSource = self
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "cell")
    }
    
    func createFlowLayout() -> UICollectionViewFlowLayout{
        let padding:CGFloat             = 12
        let flowLayout                  = UICollectionViewFlowLayout()
        flowLayout.sectionInset         = UIEdgeInsets(top: padding, left: padding, bottom: padding, right: padding)
        flowLayout.scrollDirection = .vertical
        return flowLayout
    }
}



extension ViewController: UICollectionViewDataSource{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 36
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath)
        cell.backgroundColor = .red
        return cell
    }
    
}

