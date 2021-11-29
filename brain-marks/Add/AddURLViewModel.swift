//
//  AddURLViewModel.swift
//  brain-marks
//
//  Created by Mikaela Caron on 7/13/21.
//

import SwiftUI

enum HttpError: Error {
    case badResponse
    case badURL
}

final class AddURLViewModel: ObservableObject {
    
    @Published var alertItem: AlertItem?
    
    func fetchTweet(url: String, completion: @escaping (Result<ReturnedTweet, Error>) -> Void) {
        do {
            var request = URLRequest(url: try createURL(url: url),
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
                        completion(.failure(HttpError.badResponse))
                        print("❌ Status code is \(response.statusCode)")
                        return
                    }
                    
                    guard let data = data else {
                        completion(.failure(error!))
                        return
                    }
                    
                    do {
                        let result = try JSONDecoder().decode(Response.self, from: data)
                        let user = result.includes.users.first
                        
                        let authorName = user?.name ?? ""
                        let authorUsername = user?.username ?? ""
                        let userVerified = user?.verified ?? false
                        let profileImageURL = user?.profileImageURL.replacingOccurrences(
                            of: "normal",
                            with: "bigger") ?? ""
                        var photoUrl = [String]()
                        
                        if let media = result.includes.media {
                            for item in media where (item.type == "photo") {
                                photoUrl.append(item.url)
                            }
                        }
                        let tweetToSave = ReturnedTweet(
                            id: result.data[0].id,
                            text: result.data[0].text,
                            timeStamp: result.data[0].created_at,
                            authorName: authorName,
                            authorUsername: authorUsername,
                            profileImageURL: profileImageURL,
                            userVerified: userVerified,
                            photosUrl: photoUrl)
                        
                        completion(.success(tweetToSave))
                    } catch {
                        completion(.failure(error))
                    }
                }
            }
            task.resume()
        } catch {
            completion(.failure(HttpError.badURL))
        }
    }
    
    private func createURL(url: String) throws -> URL {

        guard url.contains("twitter.com") else {
            throw HttpError.badURL
        }
        
        let id = url.components(separatedBy: "/").last!.components(separatedBy: "?")[0]
        
        var components = URLComponents()
            components.scheme = "https"
            components.host = "api.twitter.com"
            components.path = "/2/tweets"
            components.queryItems = [
                URLQueryItem(name: "ids", value: id),
                URLQueryItem(name: "expansions", value: "author_id,attachments.media_keys"),
                URLQueryItem(name: "tweet.fields", value: "created_at"),
                URLQueryItem(name: "user.fields", value: "profile_image_url,verified"),
                URLQueryItem(name: "media.fields", value: "preview_image_url,public_metrics,type,url")
            ]

            // Getting a URL from our components is as simple as
            // accessing the 'url' property.
        let componentsUrl = components.url
        
        guard let completeURL = componentsUrl
            else {
            throw HttpError.badURL
        }
        
        return completeURL
    }    
}
