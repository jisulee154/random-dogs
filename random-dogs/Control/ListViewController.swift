//
//  ListViewController.swift
//  random-dogs
//
//  Created by 이지수 on 2023/05/27.
//

import UIKit
import Alamofire

class ListViewController: UITableViewController{
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
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //return self.list.count
        return 0
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return UITableViewCell()
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        NSLog("선택된 행은 \(indexPath.row)번째 행입니다.")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.tableView.estimatedRowHeight = 200
        //self.tableView.rowHeight = UITableView.automaticDimension
    }
}

extension Bundle {
    var apiKey: String? {
        guard let file = self.path(forResource: "Keys", ofType: "plist"),
              let resource = NSDictionary(contentsOfFile: file),
              let key = resource["API_KEY"] as? String
        else {
            print("Fail to get API Key from .plist")
            return nil
        }
        return key
    }
}
