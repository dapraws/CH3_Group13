//
//  TempData.swift
//  CH3_Group13
//
//  Created by Muhammad Darrel Prawira on 23/05/26.
//

import Foundation

struct TempData {
    
    static let event1 = Event(
        name: "Kuta 5.02K Run",
        venueName: "Apple Developer Academy @BINUS",
        eventDescription: "A morning run with a precise 5.02 km route across the Academy area. Perfect for all running levels!",
        category: ["running"],
        date: Date().addingTimeInterval(86400),
        latitude: -8.736971027324335,
        longitude: 115.17593161526648,
        maxParticipants: 50,
        currentParticipants: 38,
        missions: [soloMission1, soloMission2]
    )
    
    static let event2 = Event(
        name: "Crossfit & Gym Open",
        venueName: "FIT HUB Kuta",
        eventDescription: "Weightlifting and endurance competitions.",
        category: ["gym"],
        date: Date().addingTimeInterval(172800),
        latitude: -8.735843212609703,
        longitude: 115.18154401093946,
        maxParticipants: 30,
        currentParticipants: 22,
        missions: [completedMission]
    )
    
    static let event3 = Event(
        name: "Sunset Beach Cycling",
        venueName: "Kuta Beach",
        eventDescription: "An evening cycling ride along Kuta Beach.",
        category: ["cycling"],
        date: Date().addingTimeInterval(259200),
        latitude: -8.717735116507654,
        longitude: 115.1687207615662,
        maxParticipants: 25,
        currentParticipants: 10,
        missions: []
    )

    static let allEvents: [Event] = [event1, event2, event3]
    
    // MARK: - Data Misi
    static let soloMission1 = Mission(
        name: "Snap the Spike",
        desc: "Take a photo of someone spiking the ball during a match.",
        type: .solo,
        reward: "🏐 Nice shot!"
    )

    static let soloMission2 = Mission(
        name: "Court Explorer",
        desc: "Take a selfie at each of the 3 courts.",
        type: .solo,
        reward: "🗺️ Legend!"
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
