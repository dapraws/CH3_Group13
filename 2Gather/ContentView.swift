//
//  ContentView.swift
//  CH3_Group13
//
//  Created by Muhammad Darrel Prawira on 07/05/26.
//

import SwiftData
import SwiftUI

struct ContentView: View {

    @Environment(\.modelContext) private var modelContext
    @Query private var events: [Event]

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
        .onAppear {

        }
    }

    private func seedDataIfNeeded() {
        guard events.isEmpty else { return } 
        for event in TempData.allEvents {
            modelContext.insert(event)
        }
    }
}

#Preview {
    ContentView()
}
