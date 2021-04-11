//
//  FetchTweet.swift
//  brain-marks
//
//  Created by PRABALJIT WALIA     on 11/04/21.
//

//import SwiftUI
//
//class FetchTweet:ObservableObject{
//    @Published var fetchedTweet = [TweetModel]()
//
//    func get(url:String) {
//
//        let id = url.components(separatedBy: "/").last!.components(separatedBy: "?")[0]
//        var request = URLRequest(url: URL(string: "https://api.twitter.com/2/tweets/\(id)")!,timeoutInterval: Double.infinity)
//
//        request.addValue("Bearer \(Secrets.bearerToken)", forHTTPHeaderField: "Authorization")
//
//        request.httpMethod = "GET"
//
//
//        let session = URLSession(configuration: .default)
//        session.dataTask(with: URL(string: url)!){(data,response,error) in
//            if let error = error{
//                print(error.localizedDescription)
//            }
//            guard let APIData = data else{
//                print("NO data received")
//                return
//            }
//            do{
//                //decode API data
//                let result = try JSONDecoder().decode([TweetModel].self,from:APIData)
//                DispatchQueue.main.async {
//                    self.fetchedTweet = result
//                }
//
//            }catch{
//                print(error.localizedDescription)
//
//            }
//        }.resume()
//
//    }
//}
//
