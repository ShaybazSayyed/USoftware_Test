//
//  ContentView.swift
//  USoftware_Test
//
//  Created by Shaybaz Sayyed on 13/03/25.
//
import SwiftUI

struct ContentView: View {
    var body: some View {
      
            CharacterListView()
                .navigationTitle("Characters") // 
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
