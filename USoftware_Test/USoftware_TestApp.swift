//
//  USoftware_TestApp.swift
//  USoftware_Test
//
//  Created by Shaybaz Sayyed on 13/03/25.
//
import SwiftUI
@main
struct USoftware_TestApp: App {
    var body: some Scene {
        WindowGroup {
            if ProcessInfo.processInfo.environment["UITesting"] == "true" {
                CharacterListView() // Force UI tests to start on the correct screen
            } else {
                ContentView()
            }
        }
    }
}
