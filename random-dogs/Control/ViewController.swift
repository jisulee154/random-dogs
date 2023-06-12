//
//  ListViewController.swift
//  random-dogs
//
//  Created by 이지수 on 2023/05/27.
//

import UIKit
import Alamofire

class ViewController: UIViewController {
    
    let sectionInsets = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
    
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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.getADog()
    }
    
    func getADog(){
        let url = "https://api.thedogapi.com/v1/images/search&limit=2"
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
                        //completion(.success(getInstanceData))
                        
                    } catch {
                        print(error)
                    }
                }
            case .failure(_):
                break
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
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as? UICollectionViewCell else {
            return UICollectionViewCell()
        }
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

