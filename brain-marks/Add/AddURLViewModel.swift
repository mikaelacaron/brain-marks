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

    func fetchTweet(url: String) async throws -> ReturnedTweet {
        let (data, response) = try await URLSession.shared.data(for: requestBuilder.createRequest(with: url))

        if let response = response as? HTTPURLResponse {
            guard (200 ... 299) ~= response.statusCode else {
                Logger.network.error("❌ Status code is \(response.statusCode)")
                throw HttpError.badResponse
            }

            do {
                let result = try JSONDecoder().decode(Response.self, from: data)
                return await createTweet(result)
            } catch {
                debugPrint(error)
                throw HttpError.cantDecode
            }
        } else {
            throw HttpError.badResponse
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
        
        guard let completeURL = components.url else {
            throw HttpError.badURL
        }

        return completeURL
    }
    
    private func getQuoteTweetLink(fromTweetText text: String) -> URL? {
        do {
            let regex = try NSRegularExpression(pattern: #"http(?:s)?:\/\/t\.co\/([a-zA-Z0-9_]+)"#)
            guard let linkMatch = regex.firstMatch(in: text, range: NSRange(location: 0, length: text.utf16.count)) else {
                return nil
            }
            let linkString = (text as NSString).substring(with: linkMatch.range)
            return URL(string: linkString)
        } catch {
            assertionFailure(error.localizedDescription)
            return nil
        }
       
    }
    
    private func createTweet (_ result: Response) async -> ReturnedTweet {
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
        
        lazy var plainTweet: ReturnedTweet = {
            ReturnedTweet(
                id: result.data[0].id,
                text: result.data[0].text,
                timeStamp: result.data[0].created_at,
                authorName: authorName,
                authorUsername: authorUsername,
                profileImageURL: profileImageURL,
                userVerified: userVerified,
                photosUrl: photoUrl,
                quoteTweet: nil
            )
        }()
        
        guard let quoteTweetURL = getQuoteTweetLink(fromTweetText: result.data[0].text) else {
            return plainTweet
        }
        
        do {
            let quoteTweet = try await fetchTweet(url: quoteTweetURL.absoluteString)
            return ReturnedTweet(
                id: result.data[0].id,
                text: result.data[0].text,
                timeStamp: result.data[0].created_at,
                authorName: authorName,
                authorUsername: authorUsername,
                profileImageURL: profileImageURL,
                userVerified: userVerified,
                photosUrl: photoUrl,
                quoteTweet: quoteTweet
            )
        } catch {
            debugPrint(error.localizedDescription)
            return plainTweet
        }
    }
}
