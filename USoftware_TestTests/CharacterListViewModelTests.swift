//
//  CharacterListViewModelTests.swift
//  USoftware_Test
//
//  Created by Shaybaz Sayyed on 13/03/25.
//CharacterListViewModelTests

import XCTest
@testable import USoftware_Test

class CharacterListViewModelTests: XCTestCase {
    var viewModel: CharacterListViewModel!
    var mockAPIService: MockAPIService!

    override func setUp() {
        super.setUp()
        mockAPIService = MockAPIService()
        viewModel = CharacterListViewModel()
    }

    override func tearDown() {
        viewModel = nil
        mockAPIService = nil
        super.tearDown()
    }

    func testFetchCharacters_Success() {
        let expectation = self.expectation(description: "Fetching characters from mock API")
        
        mockAPIService.fetchCharacters { result in
            switch result {
            case .success(let characters):
                XCTAssertEqual(characters.count, 2, "There should be 2 mock characters")
            case .failure:
                XCTFail("Mock API should return success")
            }
            expectation.fulfill()
        }
        
        waitForExpectations(timeout: 2, handler: nil)
    }

    func testFetchCharacters_Failure() {
        mockAPIService.shouldReturnError = true
        let expectation = self.expectation(description: "Fetching characters should fail")

        mockAPIService.fetchCharacters { result in
            switch result {
            case .success:
                XCTFail("Mock API should return failure")
            case .failure(let error):
                XCTAssertNotNil(error, "Error should be returned")
            }
            expectation.fulfill()
        }

        waitForExpectations(timeout: 2, handler: nil)
    }

    func testSearchFunctionality() {
        viewModel.characters = [
            Character(id: 1, name: "Rick Sanchez", gender: "Male", species: "Human", status: "Alive", image: ""),
            Character(id: 2, name: "Morty Smith", gender: "Male", species: "Human", status: "Alive", image: "")
        ]
        
        viewModel.searchText = "Rick"
        
        XCTAssertEqual(viewModel.filteredCharacters.count, 1, "Only one character should match the search query")
        XCTAssertEqual(viewModel.filteredCharacters.first?.name, "Rick Sanchez")
    }

}
