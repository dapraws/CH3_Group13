//
//  TempData.swift
//  CH3_Group13
//
//  Created by Muhammad Darrel Prawira on 23/05/26.
//

import Foundation

struct TempData {

    static let event1 = Event(
        name: "Bali Beach Volleyball Open",
        desc: "Open to all skill levels. come play, cheer, and soak up the sun.",
        venueName: "Kuta Beach Court",
        category: ["volleyball", "beach", "outdoor"],
        date: Date().addingTimeInterval(86400),
        latitude: -8.7184,
        longitude: 115.1686,
        photoPath: "bali-beach-volleyball",
        missions: [soloMission1, soloMission2]
    )

    static let event2 = Event(
        name: "Kuta Morning Run",
        desc: "A casual morning run along the Kuta Beach promenade.",
        venueName: "Kuta Beach Promenade",
        category: ["running", "outdoor", "casual"],
        date: Date().addingTimeInterval(172800),
        latitude: -8.7220,
        longitude: 115.1680,
        missions: [completedMission]
    )

    static let event3 = Event(
        name: "Legian Football Kickabout",
        desc: "A relaxed, friendly football session at Legian Street Field. No experience needed, just bring energy and enjoy the game.",
        venueName: "Legian Street Field",
        category: ["football", "outdoor", "casual"],
        date: Date().addingTimeInterval(259200),
        latitude: -8.7080,
        longitude: 115.1670,
        missions: [
            Mission(
                name: "First Touch",
                desc: "Take a photo of yourself on the pitch before the match starts.",
                type: .solo,
                reward: "⚽ the game begins with you!"
            ),
            Mission(
                name: "Goal Moment",
                desc: "Take a photo right after a goal is scored — celebrate it!",
                type: .solo,
                reward: "🎉 That's pure football joy!"
            )
        ]
    )

    static let event4 = Event(
        name: "Kuta Basketball Street Jam",
        desc: "Show up, run some plays, and make some noise.",
        venueName: "Kuta Sports Complex",
        category: ["basketball", "outdoor", "street"],
        date: Date().addingTimeInterval(345600),
        latitude: -8.7195,
        longitude: 115.1710,
        missions: [
            Mission(
                name: "Court Arrival",
                desc: "Take a photo of yourself at the basketball court before the game.",
                type: .solo,
                reward: "🏀 You showed up!"
            ),
            Mission(
                name: "Jump Shot",
                desc: "Take a photo of someone mid-air during a jump shot.",
                type: .solo,
                reward: "📸 You caught the perfect moment!"
            )
        ]
    )

    static let event5 = Event(
        name: "Kuta Cycling Morning Ride",
        desc: "Enjoy the quiet roads, cool breeze, and stunning sunrise views.",
        venueName: "Kuta Beach Start Point",
        category: ["cycling", "outdoor", "morning"],
        date: Date().addingTimeInterval(432000),
        latitude: -8.7160,
        longitude: 115.1695,
        missions: [
            Mission(
                name: "Sunrise Proof",
                desc: "Take a photo of the sunrise during your ride.",
                type: .solo,
                reward: "🌅 Early bird gets the view!"
            ),
            Mission(
                name: "Finish Line",
                desc: "Take a photo at the end point of the route.",
                type: .solo,
                reward: "🚴 legend on two wheels!"
            )
        ]
    )

    static let event6 = Event(
        name: "Tuban Futsal Night",
        desc: "A fast-paced indoor futsal night at Tuban Arena.",
        venueName: "Tuban Indoor Arena",
        category: ["football", "indoor", "night"],
        date: Date().addingTimeInterval(518400),
        latitude: -8.7250,
        longitude: 115.1720,
        missions: [
            Mission(
                name: "Team Photo",
                desc: "Take a group photo with your team before the match.",
                type: .solo,
                reward: "📷 Squad goals captured!"
            )
        ]
    )

    static let allEvents: [Event] = [event1, event2, event3, event4, event5, event6]

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
        reward: "🗺️ You've explored the whole venue, legend!"
    )

    static let completedMission: Mission = {
        let m = Mission(
            name: "Finish Line Proof",
            desc: "Take a photo at the finish line banner when you complete the run.",
            type: .solo,
            reward: "🏅 That's what we call a finisher!"
        )
        m.isCompleted = true
        return m
    }()
}
