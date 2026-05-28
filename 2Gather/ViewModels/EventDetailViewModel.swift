//
//  EventDetailViewModel.swift
//  CH3_Group13
//
//  Created by Muhammad Darrel Prawira on 26/05/26.
//

import SwiftUI

@Observable
class EventDetailViewModel {

    var isJoined: Bool = false
    var missions: [Mission]
    var showReward: Bool = false
    var rewardMessage: String = ""

    init(missions: [Mission]) {
        self.missions = missions
    }

    func joinEvent() {
        isJoined = true
    }

    func completeMission(_ message: String) {
        rewardMessage = message
        showReward = true
    }

    func dismissReward() {
        showReward = false
    }
}
