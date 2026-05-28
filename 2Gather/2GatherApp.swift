//
//  CH3_Group13App.swift
//  CH3_Group13
//
//  Created by Muhammad Darrel Prawira on 07/05/26.
//

import SwiftData
import SwiftUI

@main
struct TwoGatherApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .modelContainer(for: [Event.self, Mission.self, UserEventState.self])
    }
}
