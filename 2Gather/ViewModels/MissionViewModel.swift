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
    var rawUIImage: UIImage? = nil
    var captionText: String = "" 

    func openProof() {
        showProof = true
        previewImage = nil
        rawUIImage = nil
        captionText = ""
    }

    func setImage(_ uiImage: UIImage) {
        rawUIImage = uiImage
        previewImage = Image(uiImage: uiImage)
    }

    func clearImage() {
        previewImage = nil
        rawUIImage = nil
        captionText = ""
    }
}
