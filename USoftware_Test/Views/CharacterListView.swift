//
//  CharacterListView.swift
//  USoftware_Test
//
//  Created by Shaybaz Sayyed on 13/03/25.
//
import SwiftUI
/// A view that displays a list of characters with a search bar.

struct CharacterListView: View {
    @StateObject var viewModel = CharacterListViewModel()///< ViewModel that manages character data.
    @State private var showAnimation = false

    var body: some View {
        NavigationView {
            VStack {
                // Ensure Search Bar has an accessibility identifier
                UIKitSearchBar(text: $viewModel.searchText)
                    .padding(.horizontal)
                    .padding(.top, 8)
                    .accessibilityIdentifier("searchField") // Fix for UI test
                /// List of filtered characters.
                if #available(iOS 15.0, *) {
                    List(viewModel.filteredCharacters, id: \.id) { character in
                        if #available(iOS 15.0, *) {
                            NavigationLink(destination: CharacterDetailView(viewModel: CharacterDetailViewModel(character: character))) {
                                HStack {
                                    VStack(alignment: .leading, spacing: 4) {
                                        Text(character.name)
                                            .font(.headline)
                                            .foregroundColor(.primary)
                                        Text(character.gender.capitalized)
                                            .font(.subheadline)
                                            .foregroundColor(character.gender.lowercased() == "male" ? .blue : .pink)
                                    }
                                    Spacer()
                                }
                                .padding()
                                .background(RoundedRectangle(cornerRadius: 12).fill(Color(.systemGray6)))
                                .shadow(color: .gray.opacity(0.2), radius: 3, x: 0, y: 2)
                            }
                            .accessibilityIdentifier("CharacterCell_\(character.id)")
                            .listRowBackground(Color.clear)
                            .listRowSeparator(.hidden)
                        } else {
                            // Fallback on earlier versions
                        }
                    }
                    .accessibilityIdentifier("characterList") // Must be set!
                    .refreshable {
                        viewModel.fetchCharacters() // This must be in place
                    }
                    
                    .listStyle(PlainListStyle())
                } else {
                    // Fallback on earlier versions
                }
            }
            .navigationTitle("Characters")
            .padding(.horizontal, 8)
            .background(Color(.systemGroupedBackground).edgesIgnoringSafeArea(.all))
        }
    }
}
