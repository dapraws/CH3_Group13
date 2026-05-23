//
//  EventUserState.swift
//  CH3_Group13
//
//  Created by Muhammad Darrel Prawira on 23/05/26.
//

import Foundation
import SwiftData

@Model
class UserEventState {
    @Attribute(.unique) var eventId: UUID
    var joinedAt: Date?
    
    init(eventId: UUID) {
        self.eventId = eventId
        self.joinedAt = Date()
    }
}

