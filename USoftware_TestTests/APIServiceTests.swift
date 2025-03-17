//
//  APIServiceTests.swift
//  USoftware_Test
//
//  Created by Shaybaz Sayyed on 13/03/25.
//

import XCTest
import Alamofire
@testable import USoftware_Test

class APIServiceTests: XCTestCase {
    var apiService: APIService!
    var mockSession: Session!

    override func setUp() {
        super.setUp()

        let mockConfig = URLSessionConfiguration.ephemeral
        mockConfig.protocolClasses = [MockURLProtocol.self] // Use mock responses
        mockSession = Session(configuration: mockConfig)

        apiService = APIService(session: mockSession)
    }

    override func tearDown() {
        apiService = nil
        mockSession = nil
        super.tearDown()
    }

    func testFetchCharacters_Success() {
        let expectation = self.expectation(description: "Fetching characters successfully")

        MockURLProtocol.requestHandler = { request in
            let mockData = """
            {
                "results": [
                    { "id": 1, "name": "Rick Sanchez", "gender": "Male", "species": "Human", "status": "Alive", "image": "" }
                ]
            }
            """.data(using: .utf8)!

            return (HTTPURLResponse(url: request.url!, statusCode: 200, httpVersion: nil, headerFields: nil)!, mockData)
        }

        apiService.fetchCharacters { result in
            switch result {
            case .success(let characters):
                XCTAssertEqual(characters.count, 1, "Should return 1 character")
            case .failure:
                XCTFail("Expected success but got failure")
            }
            expectation.fulfill()
        }

        waitForExpectations(timeout: 3, handler: nil)
    }

    func testFetchCharacters_Failure() {
        let expectation = self.expectation(description: "Fetching characters failure")

        MockURLProtocol.requestHandler = { request in
            let error = NSError(domain: "API Error", code: 500, userInfo: nil)
            throw error
        }

        apiService.fetchCharacters { result in
            switch result {
            case .success:
                XCTFail("Expected failure but got success")
            case .failure(let error):
                XCTAssertNotNil(error, "Error should be returned")
            }
            expectation.fulfill()
        }

        waitForExpectations(timeout: 3, handler: nil)
    }
}
