//
//  AddURLViewModel.swift
//  brain-marks
//
//  Created by Mikaela Caron on 7/13/21.
//

import SwiftUI

final class AddURLViewModel: ObservableObject {
    
    func fetchTweet(url: String, completion: @escaping (Result<ReturnedTweet, Error>) -> Void) {
        
        let apiURL = "https://api.twitter.com/2/tweets"
        let expansions = "author_id&user.fields=profile_image_url"
        
        let id = url.components(separatedBy: "/").last!.components(separatedBy: "?")[0]
        var request = URLRequest(url: URL(string: "\(apiURL)?ids=\(id)&expansions=\(expansions)")!,
                                 timeoutInterval: Double.infinity)
        
        request.addValue("Bearer \(Secrets.bearerToken)", forHTTPHeaderField: "Authorization")
        
        request.httpMethod = "GET"
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            
            guard error == nil else {
                completion(.failure(error!))
                return
            }
            
            if let response = response as? HTTPURLResponse {
                guard (200 ... 299) ~= response.statusCode else {
                    completion(.failure(error!))
                    print("❌ Status code is \(response.statusCode)")
                    return
                }
                
                guard let data = data else {
                    completion(.failure(error!))
                    return
                }
                
                do {
                    let result = try JSONDecoder().decode(Response.self, from: data)
                    
                    let authorName = result.includes.users.first?.name ?? ""
                    let authorUsername = result.includes.users.first?.username ?? ""
                    let profileImageURL = result.includes.users.first?.profileImageURL ?? ""
                    
                    let tweetToSave = ReturnedTweet(id: result.data[0].id,
                                                    text: result.data[0].text,
                                                    authorName: authorName,
                                                    authorUsername: authorUsername,
                                                    profileImageURL: profileImageURL)
                    
                    completion(.success(tweetToSave))
                } catch {
                    completion(.failure(error))
                }
            }
        }
        task.resume()
    }
}
