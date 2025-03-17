//
//  MockAPIService.swift
//  USoftware_Test
//
//  Created by Shaybaz Sayyed on 13/03/25.
//
import Foundation
@testable import USoftware_Test

class MockURLProtocol: URLProtocol {
    static var requestHandler: ((URLRequest) throws -> (HTTPURLResponse, Data))?

    override class func canInit(with request: URLRequest) -> Bool {
        return true
    }

    override class func canonicalRequest(for request: URLRequest) -> URLRequest {
        return request
    }

    override func startLoading() {
        guard let handler = MockURLProtocol.requestHandler else {
            fatalError("No request handler set")
        }

        do {
            let (response, data) = try handler(request)
            client?.urlProtocol(self, didReceive: response, cacheStoragePolicy: .notAllowed)
            client?.urlProtocol(self, didLoad: data)
        } catch {
            client?.urlProtocol(self, didFailWithError: error)
        }

        client?.urlProtocolDidFinishLoading(self)
    }

    override func stopLoading() {}
}


class MockAPIService: APIServiceProtocol {
    var shouldReturnError = false
    var mockCharacters: [Character] = [
        Character(id: 1, name: "Rick Sanchez", gender: "Male", species: "Human", status: "Alive", image: ""),
        Character(id: 2, name: "Morty Smith", gender: "Male", species: "Human", status: "Alive", image: "")
    ]

    func fetchCharacters(completion: @escaping (Result<[Character], Error>) -> Void) {
        if shouldReturnError {
            completion(.failure(NSError(domain: "Mock Error", code: 500, userInfo: nil)))
        } else {
            completion(.success(mockCharacters))
        }
    }
}
