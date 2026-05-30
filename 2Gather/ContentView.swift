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
            Text("Home — coming soon")
                .tabItem {
                    Label("Home", systemImage: "house")
                }
            MapView()
                .tabItem {
                    Label("Explore", systemImage: "map")
                }
        }
        .onAppear {
            seedDataIfNeeded()
//            // debug
//            let docs = FileManager.default.urls(
//                for: .documentDirectory,
//                in: .userDomainMask
//            )[0]
//            let files = try? FileManager.default.contentsOfDirectory(
//                atPath: docs.path
//            )
//            print("📄 Files: \(files ?? [])")

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
