//
//  ListViewController.swift
//  random-dogs
//
//  Created by 이지수 on 2023/05/27.
//

import UIKit
import Alamofire

class ListViewController: UITableViewController{
    var dataset = [
        ("강아지1","설명1","2023-05-27","","1.jpg"),
        ("강아지2","설명2","2023-05-27","","2.jpg"),
        ("강아지3","설명3","2023-05-27","","3.jpg")]
    
    lazy var list: [DogVO] = {
        var doglist = [DogVO]()
        for (id, breed, date, none, thumbnail) in self.dataset {
            let dg = DogVO()
            dg.id = id
            dg.breed = breed
            dg.date = date
            dg.none = none
            dg.thumbnail = thumbnail
            
            doglist.append(dg)
        }
        return doglist
    }()
    
    //    struct Response: Codable {
    //        let dogs = [Dog]
    //
    //        enum CodingKeys: String, CodingKey {
    //            case resultCount
    //            case tracks = "results"
    //        }
    //    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.getADog()
    }
    func getADog(){
        let url = "https://api.thedogapi.com/v1/images/search?"
        AF.request(url,
                   method: .get,
                   parameters: nil,
                   encoding: URLEncoding.default,
                   headers: ["Content-Type":"application/json","Accept":"application/json"])
                .validate(statusCode: 200..<300)
                .responseJSON{(json) in
                    print(json)
                }
        /*
        //        let url = "https://api.thedogapi.com/v1/images/search?size=med&mime_types=jpg&format=json&has_breeds=true&order=RANDOM&page=0&limit=1"
        //
        //        let apiURI: URL! = URL(string: url)
        
        // SSL 보안 인증이 적용된 서버에 요청하는 것이므로, 따로 Info.plist를 수정할 필요가 없다.
        // 경고 Synchronous URL loading of https://api.thedogapi.com/v1/images/search?size=med&mime_types=jpg&format=json&has_breeds=true&order=RANDOM&page=0&limit=1 should not occur on this application's main thread as it may lead to UI unresponsiveness. Please switch to an asynchronous networking API such as URLSession.
        
        struct Response: Codable {
            let id: String
            let url: String
            let width: Int
            let height: Int
            
//            enum CodingKeys: String, CodingKey {
//                case id
//                case url
//                case width
//                case height
//            }
        }
        
        //let apidata = try! Data(contentsOf: apiURI)
        //Data(contentsOf:)를 사용하는 것보다 비동기 방식인 URLSession 활용하길 권장
        //Configuration 결정 및 Session 설정
        let config = URLSessionConfiguration.default
        let session = URLSession(configuration: config)
        //let session = URLSession.shared
        
        //Request에 사용할 url 설정
        //URLComponents 사용
        var urlComponents = URLComponents(string: "https://api.thedogapi.com/v1/images/search?")!
        
//        let sizeQuery = URLQueryItem(name: "size", value: "med")
//        let hasBreedQuery = URLQueryItem(name: "has_breeds", value: "false")
//
//        urlComponents.queryItems = [sizeQuery, hasBreedQuery]
        
        let requestURL = urlComponents.url!
        
        //print(requestURL)
        
        //Task
        
        session.dataTask(with: requestURL) {
            (data, response, error) in
            //guard let data = data else { return }
            //error == nil, let statusCode = (response as? HTTPURLResponse)?.statusCode, successRange.contains(statusCode) else {
//                print("Wrong StatusCode")
//                return
//            }
            if let error = error {
                print(error)
                return
            }
            guard let resultData = data else {
                return
            }
            print("resultData")
            
            do {
                //let decoder = JSONDecoder()
                //let response = try decoder.decode(Response.self, from: resultData)
                let result: Response = try JSONDecoder().decode(Response.self, from: resultData)
                //print(response.self.first?.id)
//                DispatchQueue.main.async {
//                    self.tableView.reloadData()
//                }
                let id = result.id
                let url = result.url
                print("id=\(id), picture url=\(url)")
                //                    let tracks = response.tracks
                //                    print(tracks.count)
                //                    for track in tracks {
                //                        print("title: \(track.title)")
                //                        print("artistName: \(track.artistName)")
                //                        print("")
            }catch (let error) {
                print("--> error: \(error.localizedDescription)")
            }
            //dataTask.resume()
            
            //            do {
            //                let decoder = JSONDecoder()
            //                let response = try decoder.decode(Response.self, from: resultData)
            //                let tracks = response.tracks
            //                print(tracks.count)
            //                for track in tracks {
            //                    print("title: \(track.title)")
            //                    print("artistName: \(track.artistName)")
            //                    print("")
            //                }
            //            } catch let error {
            //                print("--> error: \(error.localizedDescription)")
            //            }
            
        }
        
        
        /*
         //let log = NSString(data: apidata, encoding: String.Encoding.utf8.rawValue) ?? ""
         //NSLog("API Result=\( log )")
         
         // 받은 Json 객체 파싱하여 NSDictionary 객체로 받음
         //do {
         let apiDictionary = try JSONSerialization.jsonObject(with: apidata, options: [] ) as? [String: [Any]]
         //error: 더이상 JSONSerialization.jsonObject를
         
         // 데이터 구조에 따라 필요한 데이터를 캐스팅하며 읽어온다
         let resNSDict = apiDictionary
         } catch {
         //에러 프린트 추가
         print(error)
         }
         */
         */
    }
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.list.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let row = self.list[indexPath.row]
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "MyCell") as! InfoCell
        cell.id?.text = row.id
        cell.breed?.text = row.breed
        cell.date?.text = row.date
        cell.none?.text = row.none
        cell.thumbnail.image = UIImage(named: row.thumbnail!)
        
        cell.textLabel?.numberOfLines = 0 //self-sizing
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        NSLog("선택된 행은 \(indexPath.row)번째 행입니다.")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.tableView.estimatedRowHeight = 200
        //self.tableView.rowHeight = UITableView.automaticDimension
    }
}


