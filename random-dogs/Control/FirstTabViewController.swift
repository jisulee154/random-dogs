//
//  FirstTabViewController.swift
//  random-dogs
//
//  Created by 이지수 on 2023/06/16.
//

import Tabman
import UIKit
import Alamofire

class FirstTabViewController: TabmanViewController {
    @IBOutlet weak var imageView: UIImageView!
    @IBAction func GetImagePressed(_ sender: UIButton) {
        getADog()
    }
    @IBAction func SaveImagePressed(_ sender: UIButton) {
        print("==")
        print("SaveImage Btn Pressed")
        if let safeImage = dogImage {
            delegate?.sendImage(with: safeImage)
        } else {
            print("dogImage is nil")
        }
        performSegue(withIdentifier: "firstToSecond", sender: self)
    }
    
    var delegate: ImageDelegate?
    var dogImage: UIImage?
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
    
    //MARK: - View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}

extension FirstTabViewController {
    func getADog(){
        let url = "https://api.thedogapi.com/v1/images/search"
        
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
                    if let tempImage = UIImage(contentsOfFile: imagePath) {
                        
                        //download and show on UIImageView
                        DispatchQueue.main.async {
                            self.dogImage = tempImage
                            self.imageView.image = self.dogImage
                        }
                        UIImageWriteToSavedPhotosAlbum(tempImage, nil, nil, nil) //캐싱하는 것으로 바꿔야할듯
                    }
                }
            }
    }
}
