//
//  AddURLViewModel.swift
//  brain-marks
//
//  Created by Mikaela Caron on 7/13/21.
//

import SwiftUI

final class AddURLViewModel: ObservableObject {
    
    func fetchTweet(url:String, completion: @escaping (Result<ReturnedTweet, Error>) -> Void) {
        
        let id = url.components(separatedBy: "/").last!.components(separatedBy: "?")[0]
        var request = URLRequest(url: URL(string: "https://api.twitter.com/2/tweets/\(id)?expansions=author_id")!,
                                 timeoutInterval: Double.infinity)
        
        request.addValue("Bearer \(Secrets.bearerToken)", forHTTPHeaderField: "Authorization")
        
        request.httpMethod = "GET"
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data else {
                print(String(describing: error))
                
                return
            }
            
            if let response = response as? HTTPURLResponse {
                guard (200 ... 299) ~= response.statusCode else {
                    print("Status code :- \(response.statusCode)")
                    return
                }
                
                do {
                    if error == nil {
                        let result = try JSONDecoder().decode(Response.self, from: data)
                        
                        let authorName = result.includes.users.first?.name ?? ""
                        let authorUsername = result.includes.users.first?.username ?? ""
                        
                        let tweetToSave = ReturnedTweet(id: result.data.id,
                                                        text: result.data.text,
                                                        authorName: authorName,
                                                        authorUsername: authorUsername)
                        
                        completion(.success(tweetToSave))
                    }
                    
                    DispatchQueue.main.async {
                        // update UI
                    }
                    
                } catch {
                    print("\(error.localizedDescription)")
                }
            }
        }
        task.resume()
    }
}
