//
//  MissionViewModel.swift
//  CH3_Group13
//
//  Created by Muhammad Darrel Prawira on 26/05/26.
//

import SwiftUI

@Observable
class MissionViewModel {

    var showProof: Bool = false
    var showReward: Bool = false

    func openProof() {
        showProof = true
    }

    func submitProof(mission: inout Mission, onComplete: (String) -> Void) {
        mission.isCompleted = true
        showProof = false
        onComplete(mission.reward)
    }
}
