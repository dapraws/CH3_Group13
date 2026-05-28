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
    var previewImage: Image? = nil

    func openProof() {
        showProof = true
    }

    func setImage(_ uiImage: UIImage) {
        previewImage = Image(uiImage: uiImage)
    }

    func clearImage() {
        previewImage = nil
    }

    func submitProof(mission: inout Mission, onComplete: (String) -> Void) {
        mission.isCompleted = true
        showProof = false
        onComplete(mission.reward)
    }
}
