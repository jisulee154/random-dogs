//
//  ListViewController.swift
//  random-dogs
//
//  Created by 이지수 on 2023/05/27.
//

import UIKit
import Alamofire

class ViewController: UIViewController {
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var collectionView: UICollectionView!
    
    private var apiKey: String {
        get {
            guard let filepath = Bundle.main.path(forResource: "Keys", ofType: "plist") else {
                fatalError("Couldn't find file 'Keys.plist'.")
            }
            let plist = NSDictionary(contentsOfFile: filepath)
            guard let value = plist?.object(forKey: "API_KEY") as? String else {
                fatalError("Couldn't find key 'API_KEY' in 'Keys.plist'.")
                
            }
            return value
        }
    }
    
    let sectionInsets = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
    var collectedDogImages = [UIImage]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.dataSource = self
        collectionView.delegate = self
        
        self.getADog()
    }
    
    func getADog(){
        let url = "https://api.thedogapi.com/v1/images/search"
        //        let apiKey = getApiKey()
        
        let headers = ["x-api-key" : apiKey]
        let httpHeaders: HTTPHeaders = HTTPHeaders(headers)
        
        AF.request(url, method: .get, parameters: nil, headers: httpHeaders)
            .responseJSON{ response in
                switch response.result {
                case .success:
                    print(".success")
                    if let JSON = response.value {
                        do {
                            let dataJson = try JSONSerialization.data(withJSONObject: JSON, options: [])
                            let getInstanceData = try JSONDecoder().decode([DogData].self, from: dataJson)
                            print(getInstanceData)
                            let dogData = getInstanceData[0]
                            
                            self.getDogImage(with: dogData.url)
                        } catch {
                            print(error)
                        }
                    }
                case .failure(_):
                    break
                }
            }
    }
    
    func getDogImage(with url: String) {
        let destination: DownloadRequest.Destination = { _, _ in
            let documentsPath = NSSearchPathForDirectoriesInDomains(.documentDirectory,
                                                                    .userDomainMask, true)[0]
            let documentsURL = URL(fileURLWithPath: documentsPath, isDirectory: true)
            let fileURL = documentsURL.appendingPathComponent("image.jpg")
            
            return (fileURL, [.removePreviousFile, .createIntermediateDirectories]) }
        
        
        
        AF.download(url, to: destination).downloadProgress { progress in
                print("Download Progress: \(progress.fractionCompleted)")
            }
            .response { response in
                debugPrint(response)
                if response.error == nil, let imagePath = response.fileURL?.path {
                    if let dogImage = UIImage(contentsOfFile: imagePath) {
                        
                        //download and show on UIImageView
                        DispatchQueue.main.async {
                            self.imageView.image = dogImage
                        }
                        
                        self.collectedDogImages.append(dogImage)
                        let itemLocation = self.collectedDogImages.count - 1
                        let indexPaths = IndexPath(item: itemLocation, section: 0)
                        self.collectionView.insertItems(at: [indexPaths])
                        
                        UIImageWriteToSavedPhotosAlbum(dogImage, nil, nil, nil) //캐싱하는 것으로 바꿔야할듯
                    }
                }
            }
    }
}

//MARK: - UICollectionView
extension ViewController: UICollectionViewDataSource,
                          UICollectionViewDelegate,
                          UICollectionViewDelegateFlowLayout
{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return collectedDogImages.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
//        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as? UICollectionViewCell else {
//            return UICollectionViewCell()
//        }
//
//        return cell
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath)
        let imageData = collectedDogImages[indexPath.row]
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

