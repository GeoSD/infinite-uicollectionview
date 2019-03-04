//
//  ViewController.swift
//  ExampleInfiniteScrollView
//
//  Created by Mason L'Amy on 04/08/2015.
//  Copyright (c) 2015 Maso Apps Ltd. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    fileprivate let cellItems = (0...719).map { (cell) -> Int in
        if cell % 60 == 0 {
            return 2
        } else if cell % 60 != 0 && cell % 15 == 0 {
            return 1
        }
        return 0
    }
    
    @IBOutlet weak var infiniteCollectionView: InfiniteCollectionView! {
        didSet {
            infiniteCollectionView.backgroundColor = UIColor.clear
            infiniteCollectionView.register(UINib(nibName: "ExampleCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "cellCollectionView")
            infiniteCollectionView.infiniteDataSource = self
            infiniteCollectionView.infiniteDelegate = self
            infiniteCollectionView.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        infiniteCollectionView.setCenterCell(index: 30)
    }
    
    @IBAction func turnLeft(_ sender: UIButton) {
        infiniteCollectionView.turnLeft()
        
    }
    @IBAction func turnRight(_ sender: UIButton) {
        infiniteCollectionView.turnRight()
    }
}

extension ViewController: InfiniteCollectionViewDataSource {
    func numberOfItems(_ collectionView: UICollectionView) -> Int {
        return cellItems.count
    }
    
    func cellForItemAtIndexPath(_ collectionView: UICollectionView, dequeueIndexPath: IndexPath, usableIndexPath: IndexPath)  -> UICollectionViewCell {
        let cell = infiniteCollectionView.dequeueReusableCell(withReuseIdentifier: "cellCollectionView", for: dequeueIndexPath) as! ExampleCollectionViewCell
        cell.heightConstraint.constant = CGFloat(20 * cellItems[usableIndexPath.row])
        cell.viewww.layoutIfNeeded()
//        cell.lbTitle.text = cellItems[usableIndexPath.row]
//        cell.backgroundImage.image = UIImage(named: "cell-1")
        return cell
    }
}

extension ViewController: InfiniteCollectionViewDelegate {
    func didSelectCellAtIndexPath(_ collectionView: UICollectionView, usableIndexPath: IndexPath) {
        print("Selected cell with name \(usableIndexPath.row)")
    }
}
