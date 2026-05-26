//
//  ContentView.swift
//  CH3_Group13
//
//  Created by Muhammad Darrel Prawira on 07/05/26.
//

import SwiftUI
import SwiftData

struct ContentView: View {
    var body: some View {
        TabView {
            MapView()
                .tabItem {
                    Label("Explore", systemImage: "map")
                }
            Text("My Missions — coming soon")
                .tabItem {
                    Label("Missions", systemImage: "list.bullet")
                }
            Text("Profile — coming soon")
                .tabItem {
                    Label("Profile", systemImage: "person")
                }
        }
    }
}

#Preview {
    ContentView()
}
