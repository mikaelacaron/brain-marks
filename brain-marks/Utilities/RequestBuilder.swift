//
//  RequestBuilder.swift
//  brain-marks
//
//  Created by Drag0ndust on 06.10.22.
//

import Foundation

protocol RequestBuildable {
    func createRequest(with urlString: String) throws -> URLRequest
}

struct RequestBuilder {
    private let bearerToken: String

    init(bearerToken: String = Secrets.bearerToken) {
        self.bearerToken = bearerToken
    }
}

// MARK: - RequestBuildable
extension RequestBuilder: RequestBuildable {
    func createRequest(with urlString: String) throws -> URLRequest {
        var request = URLRequest(url: try createURL(url: urlString),
                                 timeoutInterval: Double.infinity)

        request.addValue("Bearer \(bearerToken)", forHTTPHeaderField: "Authorization")

        request.httpMethod = "GET"
        return request
    }
}

// MARK: - Private methods
private extension RequestBuilder {
    func createURL(url: String) throws -> URL {
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
}
