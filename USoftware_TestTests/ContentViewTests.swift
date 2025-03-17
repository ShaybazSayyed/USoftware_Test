//
//  ContentViewTests.swift
//  USoftware_Test
//
//  Created by Shaybaz Sayyed on 13/03/25.
//

import XCTest
import SwiftUI
@testable import USoftware_Test

final class ContentViewTests: XCTestCase {
    
    func testContentViewRenders() {
        let contentView = ContentView()
        let view = UIHostingController(rootView: contentView)
        
        XCTAssertNotNil(view.view, "ContentView should load properly")
    }
  
}


