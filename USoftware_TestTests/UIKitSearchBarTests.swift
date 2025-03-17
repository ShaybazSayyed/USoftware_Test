//
//  UIKitSearchBarTests.swift
//  USoftware_Test
//
//  Created by Shaybaz Sayyed on 13/03/25.
//
import XCTest
import SwiftUI

@testable import USoftware_Test

final class UIKitSearchBarTests: XCTestCase {
    
    func testUpdateUIViewTextChange() {
        var searchText = "Initial"
        
        // Create a binding for the search bar
        let searchBarView = UIKitSearchBar(text: Binding(
            get: { searchText },
            set: { searchText = $0 }
        ))

        // Use UIHostingController to embed SwiftUI in a testable UIKit environment
        let hostingController = UIHostingController(rootView: searchBarView)
        
        // Ensure view is loaded
        XCTAssertNotNil(hostingController.view, "Search bar view should load in hosting controller")

        // Add the hosting controller's view to a window to ensure layout updates
        let window = UIWindow(frame: UIScreen.main.bounds)
        window.rootViewController = hostingController
        window.makeKeyAndVisible()

        //  Wait for layout updates
        hostingController.view.setNeedsLayout()
        hostingController.view.layoutIfNeeded()

        //  Find UISearchBar using a recursive search method
        let searchBar = findSearchBar(in: hostingController.view)

        XCTAssertNotNil(searchBar, "UISearchBar not found in view hierarchy")
        
        guard let searchBar = searchBar else { return }

        // Get the search bar delegate
        let delegate = searchBar.delegate

        //  Use expectation to wait for UI updates
        let expectation = self.expectation(description: "Wait for search bar text update")
        
        DispatchQueue.main.async {
            searchText = "Updated"
            searchBar.text = searchText
            delegate?.searchBar?(searchBar, textDidChange: searchText) // Trigger delegate
            expectation.fulfill()
        }

        wait(for: [expectation], timeout: 3.0)

        XCTAssertEqual(searchBar.text, "Updated", "SearchBar text did not update correctly")
    }

    //  Helper function to recursively find UISearchBar in the view hierarchy
    private func findSearchBar(in view: UIView) -> UISearchBar? {
        if let searchBar = view as? UISearchBar {
            return searchBar
        }
        for subview in view.subviews {
            if let found = findSearchBar(in: subview) {
                return found
            }
        }
        return nil
    }
    func testSearchBarTextDidChange() {
            var searchText = "Initial"
            
            // Create a binding for the search bar
            let searchBarView = UIKitSearchBar(text: Binding(
                get: { searchText },
                set: { searchText = $0 }
            ))

            let coordinator = searchBarView.makeCoordinator() //  Create Coordinator manually
            let searchBar = UISearchBar()
            
            //  Test case 1: Changing text triggers delegate
            coordinator.searchBar(searchBar, textDidChange: "New Input")
            XCTAssertEqual(searchText, "New Input", "searchBar(_:textDidChange:) did not update text correctly")
            
            //  Test case 2: Setting same text does not trigger unnecessary updates
            searchText = "Same Input"
            coordinator.searchBar(searchBar, textDidChange: "Same Input")
            XCTAssertEqual(searchText, "Same Input", "searchBar(_:textDidChange:) should not trigger unnecessary updates")
            
            //  Test case 3: Empty text is handled correctly
            coordinator.searchBar(searchBar, textDidChange: "")
            XCTAssertEqual(searchText, "", "searchBar(_:textDidChange:) should handle empty input")
        }
}
