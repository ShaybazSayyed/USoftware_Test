//
//  UIKitSearchBar.swift
//  USoftware_Test
//
//  Created by Shaybaz Sayyed on 13/03/25.
//
import SwiftUI
import UIKit

struct UIKitSearchBar: UIViewRepresentable {
    @Binding var text: String

    class Coordinator: NSObject, UISearchBarDelegate {
        var parent: UIKitSearchBar

        init(parent: UIKitSearchBar) {
            self.parent = parent
        }

        func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
            if parent.text != searchText { // Prevent infinite loops
                parent.text = searchText
            }
        }
    }

    func makeCoordinator() -> Coordinator {
        return Coordinator(parent: self)
    }

    func makeUIView(context: Context) -> UISearchBar {
        let searchBar = UISearchBar()
        searchBar.delegate = context.coordinator
        searchBar.placeholder = "Search here"
        searchBar.accessibilityIdentifier = "SearchBar" // Ensure identifier is set
        return searchBar
    }

    func updateUIView(_ uiView: UISearchBar, context: Context) {
        if uiView.text != text { // Ensure text sync
            uiView.text = text
        }
    }
}
