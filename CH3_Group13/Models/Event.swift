//
//  Event.swift
//  CH3_Group13
//
//  Created by Muhammad Darrel Prawira on 23/05/26.
//

import Foundation
import SwiftData

@Model
class Event {
    @Attribute(.unique) var id: UUID
    var name: String
    var category: [String]
    var date: Date
    var latitude: Double
    var longitude: Double
    var photosPath: [String]
    @Relationship(deleteRule: .cascade) var missions: [Mission]
    
    init(
        id: UUID = UUID(),
        name: String,
        category: [String] = [],
        date: Date = Date(),
        latitude: Double,
        longitude: Double,
        photosPath: [String] = [],
        missions: [Mission] = []
    ) {
        self.id = id
        self.name = name
        self.category = category
        self.date = date
        self.latitude = latitude
        self.longitude = longitude
        self.photosPath = photosPath
        self.missions = missions
    }
}
