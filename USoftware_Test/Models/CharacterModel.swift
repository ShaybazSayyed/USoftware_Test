//
//  CharacterModel.swift
//  USoftware_Test
//
//  Created by Shaybaz Sayyed on 13/03/25.
//
import Foundation

/// Represents a character entity retrieved from the API.
/// /// Coding keys to map JSON keys with Swift properties.

struct Character: Codable, Identifiable {
    let id: Int
    let name: String
    let gender: String
    let species: String
    let status: String
    let image: String
}

struct APIResponse: Codable {
    let results: [Character]
}
