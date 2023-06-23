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
    //var readyImages: [UIImage]?
    
    let sectionInsets = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.dataSource = self
        collectionView.delegate = self
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        let ad = UIApplication.shared.delegate as? AppDelegate
        
//        if let readyImages = ad?.collectedImages {
//            print("cell count = \(readyImages.count)")
//        } else {
//            print("ad?.collectedImages is nil.")
//        }
        
//        print("SecondTabVC - viewDidAppear()")
//        if let itemLocation = ad?.collectedImages.count {
//            let indexPaths = IndexPath(item: itemLocation, section: 0)
//
//            self.collectionView.insertItems(at: [indexPaths])
//        }
//
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
        
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as? UICollectionViewCell {
            print("indexPath.row - \(indexPath.row)")
            if let imageData = ad?.collectedImages[indexPath.row] {
                let appendingView = UIView(frame: CGRect.init())
                let appendingImageView = UIImageView(image: imageData)
                appendingView.addSubview(appendingImageView)
                
                cell.contentView.addSubview(appendingView)
                print("add Sub View - \(indexPath.row)")
            }
            return cell
        }
        else {
            return UICollectionViewCell()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
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

////MARK: - InsertImageDelegate
//extension SecondTabViewController: ImageDelegate {
//    func sendImage(with image: UIImage) {
//        print("secondTab delegate method activated") // test
//
//        self.collectedDogImages.append(image)
//        let itemLocation = self.collectedDogImages.count
//        let indexPaths = IndexPath(item: itemLocation, section: 0)
//
//        self.collectionView.insertItems(at: [indexPaths])
//    }
//}
