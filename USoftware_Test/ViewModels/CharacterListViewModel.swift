//
//  CharacterListViewModel.swift
//  USoftware_Test
//
//  Created by Shaybaz Sayyed on 13/03/25.
//
import Foundation
import Combine

/// ViewModel responsible for handling character data retrieval and search functionality.

class CharacterListViewModel: ObservableObject {
    @Published var characters: [Character] = []
    @Published var filteredCharacters: [Character] = [] // New filtered list
    @Published var searchText: String = "" {
        didSet {
            applySearchFilter()
        }
    }// Stores the search query input.

    private var apiService = APIService()
    private var cancellables = Set<AnyCancellable>()

    init() {
        fetchCharacters()
    }
    
    /// Fetches characters from the API and updates the `characters` array.

    func fetchCharacters() {
        if ProcessInfo.processInfo.environment["UITesting"] == "true" {
            DispatchQueue.main.asyncAfter(deadline: .now() + 2) { // Simulating API response delay
                self.characters = [
                    Character(id: 1, name: "Rick Sanchez", gender: "Male", species: "Human", status: "Alive", image: "rick_image_url"),
                    Character(id: 2, name: "Morty Smith", gender: "Male", species: "Human", status: "Alive", image: "morty_image_url")
                ]
                self.filteredCharacters = self.characters
            }
            return
        }

        apiService.fetchCharacters { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .success(let characters):
                    self?.characters = characters
                    self?.filteredCharacters = characters
                case .failure:
                    self?.characters = []
                    self?.filteredCharacters = []
                }
            }
        }
    }

    /// Computed property that filters characters based on search text.

    private func applySearchFilter() {
        if searchText.isEmpty {
            filteredCharacters = characters
        } else {
            filteredCharacters = characters.filter {
                $0.name.lowercased().contains(searchText.lowercased())
            }
        }
    }
}
