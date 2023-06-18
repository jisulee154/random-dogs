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
    @IBOutlet weak var testLabel: UILabel!
    
    var collectedDogImages = [UIImage]()
    let sectionInsets = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
    
    override func viewDidLoad() {
        collectionView.dataSource = self
        collectionView.delegate = self
        
//        guard let firstTabVC = self.storyboard?.instantiateViewController(withIdentifier: "FirstTabVC") as? FirstTabViewController
//        else { return }
//        firstTabVC.delegate = self
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "firstToSecond" {
            let firstTabVC: FirstTabViewController = segue.destination as! FirstTabViewController
            firstTabVC.delegate = self
        }
    }
}

//MARK: - CollectionView
extension SecondTabViewController: UICollectionViewDataSource,
                                   UICollectionViewDelegate,
                                   UICollectionViewDelegateFlowLayout
{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return collectedDogImages.count
//        return 10
    }
    
//    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
//        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath)
//        let imageData = collectedDogImages[indexPath.row]
//        let appendingView = UIView(frame: CGRect.init())
//        let appendingImageView = UIImageView(image: imageData)
//        appendingView.addSubview(appendingImageView)
//
//        cell.contentView.addSubview(appendingView)
//        return cell
//    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as? UICollectionViewCell
        else {
            return UICollectionViewCell()
        }
        let imageData = collectedDogImages[indexPath.row - 1
        ]
        let appendingView = UIView(frame: CGRect.init())
        let appendingImageView = UIImageView(image: imageData)
        appendingView.addSubview(appendingImageView)

        cell.contentView.addSubview(appendingView)
        return cell
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

//MARK: - InsertImageDelegate
extension SecondTabViewController: ImageDelegate {
    func sendImage(with image: UIImage) {
        print("=")
        print("secondTab delegate method activated")
        self.collectedDogImages.append(image)
        let itemLocation = self.collectedDogImages.count
        let indexPaths = IndexPath(item: itemLocation, section: 0)
        //test
        testLabel.text = "passed"
        
        self.collectionView.insertItems(at: [indexPaths])
    }
}
