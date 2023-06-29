//
//  SecondTabViewController.swift
//  random-dogs
//
//  Created by 이지수 on 2023/06/16.
//

import Foundation
import Tabman

class SecondTabViewController: TabmanViewController {
    @IBOutlet weak var collectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.dataSource = self
        collectionView.delegate = self
        
        collectionView.register(UINib(nibName: "CustomCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "CustomCell")
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        collectionView.reloadData()
    }
}

//MARK: - CollectionView
extension SecondTabViewController: UICollectionViewDataSource,
                                   UICollectionViewDelegate,
                                   UICollectionViewDelegateFlowLayout
{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        let ad = UIApplication.shared.delegate as? AppDelegate
        
        if let count = ad?.collectedImages.count {
            print("cell count = \(count)")
            return count
        } else {
            return 1
        }
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let ad = UIApplication.shared.delegate as? AppDelegate
        
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CustomCell", for: indexPath) as? CustomCollectionViewCell {
            
            if let imageInfo = ad?.collectedImages[indexPath.row] {
                cell.cellImageView.image = imageInfo.imageData
                cell.cellImageView.contentMode = UIImageView.ContentMode.scaleAspectFill
            }
            return cell
        }
        else {
            return UICollectionViewCell()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let sectionInsets = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        
        let width = collectionView.frame.width
        let height = collectionView.frame.height
        let itemsPerRow: CGFloat = 2
        let widthPadding = sectionInsets.left * (itemsPerRow + 1)
        let itemsPerColumn: CGFloat = 3
        let heightPadding = sectionInsets.top * (itemsPerColumn + 1)
        let cellWidth = (width - widthPadding) / itemsPerRow
        let cellHeight = (height - heightPadding) / itemsPerColumn
        
        return CGSize(width: cellWidth, height: cellHeight)
    }
}
