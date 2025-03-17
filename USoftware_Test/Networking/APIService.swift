//
//  APIService.swift
//  USoftware_Test
//
//  Created by Shaybaz Sayyed on 13/03/25.
//
import Foundation
import Alamofire

protocol APIServiceProtocol {
    func fetchCharacters(completion: @escaping (Result<[Character], Error>) -> Void)
}

/// A singleton service responsible for making API requests.

class APIService: APIServiceProtocol {
    private let baseURL = "https://rickandmortyapi.com/api/character"
    private let session: Session // Injected session for testing

    init(session: Session = AF) {
        self.session = session
    }
    /// Fetches a list of characters from the API.

    func fetchCharacters(completion: @escaping (Result<[Character], Error>) -> Void) {
        session.request(baseURL)
            .validate()
            .responseDecodable(of: APIResponse.self) { response in
                switch response.result {
                case .success(let data):
                    DispatchQueue.main.async {
                        completion(.success(data.results))
                    }
                case .failure(let error):
                    DispatchQueue.main.async {
                        completion(.failure(error))
                    }
                }
            }
    }
}
