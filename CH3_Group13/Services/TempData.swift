//
//  TempData.swift
//  CH3_Group13
//
//  Created by Muhammad Darrel Prawira on 23/05/26.
//

import Foundation

struct TempData {

    // Events

    static let event1 = Event(
        name: "Bali Beach Volleyball Open",
        category: ["volleyball", "beach", "outdoor"],
        date: Date().addingTimeInterval(86400),
        latitude: -8.7184,
        longitude: 115.1686,
        missions: [soloMission1, soloMission2]
    )

    static let event2 = Event(
        name: "Seminyak Sunday Run",
        category: ["running", "outdoor", "casual"],
        date: Date().addingTimeInterval(172800),
        latitude: -8.6916,
        longitude: 115.1589,
        missions: [completedMission]
    )

    static let event3 = Event(
        name: "Ubud Football Kickabout",
        category: ["football", "outdoor", "casual"],
        date: Date().addingTimeInterval(259200),
        latitude: -8.5069,
        longitude: 115.2625,
        missions: [
            Mission(
                name: "First Touch",
                desc: "Take a photo of yourself on the pitch before the match starts.",
                type: .solo,
                reward: "⚽ You're on the pitch — the game begins with you!"
            ),
            Mission(
                name: "Goal Moment",
                desc: "Take a photo right after a goal is scored — celebrate it!",
                type: .solo,
                reward: "🎉 You captured a goal moment. That's pure football joy!"
            )
        ]
    )

    static let allEvents: [Event] = [event1, event2, event3]
    
    // Missions

    static let soloMission1 = Mission(
        name: "Snap the Spike",
        desc: "Take a photo of someone spiking the ball during a match.",
        type: .solo,
        reward: "🏐 Nice shot! You captured the energy of the game!"
    )

    static let soloMission2 = Mission(
        name: "Court Explorer",
        desc: "Take a selfie at each of the 3 courts.",
        type: .solo,
        reward: "🗺️ You've explored the whole venue — legend!"
    )

    static let completedMission: Mission = {
        let m = Mission(
            name: "Finish Line Proof",
            desc: "Take a photo at the finish line banner when you complete the run.",
            type: .solo,
            reward: "🏅 You crossed the line! That's what we call a finisher!"
        )
        m.isCompleted = true
        return m
    }()
}
