//
//  MissionProofView.swift
//  CH3_Group13
//
//  Created by Muhammad Darrel Prawira on 23/05/26.
//

import SwiftUI
import PhotosUI

struct MissionProofView: View {

    var mission: Mission
    var onSubmit: () -> Void = {}

    @State private var selectedItem: PhotosPickerItem? = nil

    @State private var previewImage: Image? = nil

    var body: some View {
        VStack(spacing: 24) {

            Text(mission.name)
                .font(.title2)
                .bold()

            Text(mission.desc)
                .foregroundStyle(.secondary)
                .multilineTextAlignment(.center)

            PhotosPicker(
                selection: $selectedItem,
                matching: .images
            ) {
                ZStack {
                    RoundedRectangle(cornerRadius: 12)
                        .fill(Color.gray.opacity(0.15))
                        .frame(maxWidth: .infinity)
                        .frame(height: 200)

                    if let previewImage {
                        previewImage
                            .resizable()
                            .scaledToFill()
                            .frame(maxWidth: .infinity)
                            .frame(height: 200)
                            .clipShape(RoundedRectangle(cornerRadius: 12))
                    } else {
                        VStack(spacing: 8) {
                            Image(systemName: "camera")
                                .font(.largeTitle)
                                .foregroundStyle(.gray)

                            Text("Tap to pick a photo")
                                .font(.caption)
                                .foregroundStyle(.gray)
                        }
                    }
                }
            }

            Button("Submit Proof") {
                // TODO (Darrel): logic
                onSubmit()
            }
            .buttonStyle(.borderedProminent)
            .disabled(previewImage == nil)

        }
        .padding()
        .onChange(of: selectedItem) { _, newItem in
            Task {
                if let data = try? await newItem?.loadTransferable(type: Data.self),
                   let uiImage = UIImage(data: data) {
                    previewImage = Image(uiImage: uiImage)
                }
            }
        }
    }
}

#Preview {
    MissionProofView(mission: TempData.soloMission1)
}
