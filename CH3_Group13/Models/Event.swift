//
//  Event.swift
//  CH3_Group13
//
//  Created by Muhammad Darrel Prawira on 23/05/26.
//

import Foundation
import SwiftData
import MapKit
import SwiftUI

@Model
class Event {
    @Attribute(.unique) var id: UUID
    var name: String
    var venueName: String
    var eventDescription: String
    var category: [String]
    var date: Date
    var latitude: Double
    var longitude: Double
    var photoPath: String?
    
    var maxParticipants: Int
    var currentParticipants: Int
    
    @Relationship(deleteRule: .cascade) var missions: [Mission]

    init(
        id: UUID = UUID(),
        name: String,
        venueName: String = "Unknown Venue",
        eventDescription: String = "",
        category: [String] = [],
        date: Date = Date(),
        latitude: Double,
        longitude: Double,
        photoPath: String? = nil,
        maxParticipants: Int = 50,
        currentParticipants: Int = 0,
        missions: [Mission] = []
    ) {
        self.id = id
        self.name = name
        self.venueName = venueName
        self.eventDescription = eventDescription
        self.category = category
        self.date = date
        self.latitude = latitude
        self.longitude = longitude
        self.photoPath = photoPath
        self.maxParticipants = maxParticipants
        self.currentParticipants = currentParticipants
        self.missions = missions
    }

    var formattedDate: String {
        let formatter = DateFormatter()
        formatter.dateStyle = .full
        formatter.timeStyle = .none
        return formatter.string(from: date)
    }
    
    var formattedTime: String {
        let formatter = DateFormatter()
        formatter.dateStyle = .none
        formatter.timeStyle = .short
        return formatter.string(from: date)
    }
    
    @Transient var coordinate: CLLocationCoordinate2D {
        CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
    }
    
    @Transient var systemImage: String {
        let primaryCat = category.first?.lowercased() ?? ""
        switch primaryCat {
        case "running": return "figure.run"
        case "gym", "crossfit": return "dumbbell.fill"
        case "cycling": return "figure.outdoor.cycle"
        case "recovery", "dining": return "fork.knife"
        default: return "list.bullet"
        }
    }
    
    @Transient var tintColor: Color {
        let primaryCat = category.first?.lowercased() ?? ""
        switch primaryCat {
        case "running": return .orange
        case "gym", "crossfit": return .red
        case "cycling": return .green
        case "recovery", "dining": return .purple
        default: return .blue
        }
    }
    
    @Transient var spotsLeft: Int { maxParticipants - currentParticipants }
    @Transient var isFull: Bool { spotsLeft <= 0 }
}
