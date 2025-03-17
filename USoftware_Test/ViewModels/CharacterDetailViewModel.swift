//
//  CharacterDetailViewModel.swift
//  USoftware_Test
//Test
//  Created by Shaybaz Sayyed on 13/03/25.
//
import Foundation

class CharacterDetailViewModel: ObservableObject {
    let character: Character

    init(character: Character) {
        self.character = character
    }
}
