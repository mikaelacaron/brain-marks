//
//  AddURLViewModel.swift
//  brain-marks
//
//  Created by Mikaela Caron on 7/13/21.
//

import SwiftUI
import os.log

enum HttpError: Error {
    case badResponse
    case badURL
    case cantDecode
}

final class AddURLViewModel: ObservableObject {
    
    @Published var alertItem: AlertItem?

    private let requestBuilder: RequestBuildable

    init(requestBuilder: RequestBuildable = RequestBuilder()) {
        self.requestBuilder = requestBuilder
    }
    
    func fetchTweet(url: String, completion: @escaping (Result<ReturnedTweet, Error>) -> Void) {
        do {
            let request = try requestBuilder.createRequest(with: url)
            
            let task = URLSession.shared.dataTask(with: request) { [weak self] data, response, error in
                
                guard error == nil else {
                    completion(.failure(error!))
                    return
                }
                
                if let response = response as? HTTPURLResponse {
                    guard (200 ... 299) ~= response.statusCode else {
                        completion(.failure(HttpError.badResponse))
                        Logger.network.error("❌ Status code is \(response.statusCode)")
                        return
                    }
                    
                    guard let data = data else {
                        completion(.failure(error!))
                        return
                    }
                    
                    do {
                        let result = try JSONDecoder().decode(Response.self, from: data)
                        
                        guard let tweetToSave = self?.createTweet(result) else {
                            completion(.failure(HttpError.cantDecode))
                            return
                        }
                        
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
    
    private func createTweet (_ result: Response) -> ReturnedTweet {
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
        
        return tweetToSave
    }
}
