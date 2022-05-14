//
//  TwitterAPI.swift
//  brain-marks
//
//  Created by Andrew Erickson on 2022-05-13.
//

import Foundation

class TwitterAPI {

    private static let baseURL = "https://api.twitter.com/2/"

    enum Endpoint: String {
        case tweets
    }

    static func fetchTweet(
        url urlString: String,
        completion: @escaping (Result<ReturnedTweet, Error>) -> Void
    ) {
        guard
            let url = URL(string: urlString),
            let host = url.host,
            host == "twitter.com"
        else {
            completion(.failure(HttpError.badURL))
            return
        }

        let tweetId = url.lastPathComponent

        guard let request = createFetchTweetRequest(tweetId: tweetId) else {
            completion(.failure(HttpError.badRequest))
            return
        }

        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            processResponse(data: data, response: response, error: error, completion: completion)
        }
        task.resume()
    }

    private static func processResponse(
        data: Data?,
        response: URLResponse?,
        error: Error?,
        completion: @escaping (Result<ReturnedTweet, Error>) -> Void
    ) {
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
                let profileImageURL = user?.profileImageURL.replacingOccurrences(
                    of: "normal",
                    with: "bigger") ?? ""
                let data = result.data[0]
                let photo = result.includes.media?.first(where: { $0.type == "photo" })

                let tweetToSave = ReturnedTweet(
                    id: data.id,
                    text: data.text,
                    authorName: authorName,
                    authorUsername: authorUsername,
                    profileImageURL: profileImageURL,
                    imageURL: photo?.url
                )

                completion(.success(tweetToSave))
            } catch {
                completion(.failure(error))
            }
        }
    }

    private static func createFetchTweetRequest(tweetId: String) -> URLRequest? {
        guard var requestComponents = URLComponents(string: baseURL) else { return nil }

        requestComponents.queryItems = [
            URLQueryItem(name: "ids", value: tweetId),
            URLQueryItem(name: "expansions", value: "author_id,attachments.media_keys"),
            URLQueryItem(name: "user.fields", value: "profile_image_url"),
            URLQueryItem(name: "media.fields", value: "type,url")
        ]

        guard let url = requestComponents.url else { return nil }

        var request = URLRequest(
            url: url.appendingPathComponent(Endpoint.tweets.rawValue),
            timeoutInterval: Double.infinity
        )
        request.addValue("Bearer \(Secrets.bearerToken)", forHTTPHeaderField: "Authorization")
        request.httpMethod = "GET"

        return request
    }
}

enum HttpError: Error {
    case badResponse
    case badURL
    case badRequest
}
