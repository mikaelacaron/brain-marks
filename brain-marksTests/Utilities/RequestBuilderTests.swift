//
//  RequestBuilderTests.swift
//  brain-marksTests
//
//  Created by Drag0ndust on 06.10.22.
//

import XCTest
@testable import brain_marks

final class RequestBuilderTests: XCTestCase {
    private var sut: RequestBuilder!

    // swiftlint:disable:next line_length
    private let tweetUrl = "https://twitter.com/drag0ndust/status/1577696984974106627?s=20&t=-HhNNcMGO5Sqicfs-vRzoQ"

    override func setUpWithError() throws {
        let testBearerToken = "test"
        sut = RequestBuilder(bearerToken: testBearerToken)
    }

    func testUrlIsNotValidTwitterUrl() {
        XCTAssertThrowsError(try sut.createRequest(with: "https://www.google.com")) { error in
            guard let error = error as? HttpError else {
                XCTFail("Found unexpected error type")
                return
            }
            XCTAssertEqual(error, HttpError.badURL)
        }
    }

    func testAddingBearerToken() throws {
        let request = try sut.createRequest(with: tweetUrl)
        let bearerTokenHeaderValue = request.value(forHTTPHeaderField: "Authorization")
        XCTAssertEqual(bearerTokenHeaderValue, "Bearer test")
    }

    func testIsGetRequest() throws {
        let request = try sut.createRequest(with: tweetUrl)
        XCTAssertEqual(request.httpMethod, "GET")
    }

    func testGeneratedURLContainsExpectedComponents() throws {
        let request = try sut.createRequest(with: tweetUrl)

        guard let url = request.url else {
            XCTFail("No valid url generated")
            return
        }
        let urlString = url.absoluteString

        // ID
        XCTAssertTrue(urlString.contains("ids=1577696984974106627&"))

        // Expansions
        XCTAssertTrue(urlString.contains("expansions=author_id,attachments.media_keys"))

        // Tweet fields
        XCTAssertTrue(urlString.contains("tweet.fields=created_at"))

        // User fields
        XCTAssertTrue(urlString.contains("user.fields=profile_image_url,verified"))

        // Media fields
        XCTAssertTrue(urlString.contains("media.fields=preview_image_url,public_metrics,type,url"))
    }
}
