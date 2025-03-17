//
//  CharacterDetailViewModelTests.swift
//  USoftware_Test
//
//  Created by Shaybaz Sayyed on 13/03/25.
//

import XCTest
@testable import USoftware_Test

final class CharacterDetailViewModelTests: XCTestCase {
    
    func testCharacterDetailViewModelInitialization() {
        // Given: A sample character
        let character = Character(id: 1, name: "Rick Sanchez", gender: "Male", species: "Human", status: "Alive", image: "")

        // When: Initializing the ViewModel
        let viewModel = CharacterDetailViewModel(character: character)

        // Then: Ensure properties are correctly assigned
        XCTAssertEqual(viewModel.character.id, 1, "Character ID should match")
        XCTAssertEqual(viewModel.character.name, "Rick Sanchez", "Character name should match")
        XCTAssertEqual(viewModel.character.gender, "Male", "Character gender should match")
        XCTAssertEqual(viewModel.character.species, "Human", "Character species should match")
        XCTAssertEqual(viewModel.character.status, "Alive", "Character status should match")
        XCTAssertEqual(viewModel.character.image, "", "Character image URL should match")
    }
}
