//
//  MissionProofView.swift
//  CH3_Group13
//
//  Created by Muhammad Darrel Prawira on 23/05/26.
//

import SwiftUI

struct MissionProofView: View {

    @Binding var mission: Mission
    var viewModel: MissionViewModel
    var onSubmit: () -> Void = {}

    @State private var showCamera: Bool = false

    var body: some View {
        VStack(spacing: 24) {

            Text(mission.name)
                .font(.title2)
                .bold()

            Text(mission.desc)
                .foregroundStyle(.secondary)
                .multilineTextAlignment(.center)

            ZStack {
                RoundedRectangle(cornerRadius: 12)
                    .fill(Color.gray.opacity(0.15))
                    .frame(maxWidth: .infinity)
                    .frame(height: 200)

                if let previewImage = viewModel.previewImage {
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
                        Text("Tap to take a photo")
                            .font(.caption)
                            .foregroundStyle(.gray)
                    }
                }
            }
            .onTapGesture {
                showCamera = true
            }

            if viewModel.previewImage != nil {
                Button("Retake") {
                    showCamera = true
                }
                .foregroundStyle(.secondary)
            }

            Button("Submit Proof") {
                onSubmit()
            }
            .buttonStyle(.borderedProminent)
            .disabled(viewModel.previewImage == nil)
        }
        .padding()
        .fullScreenCover(isPresented: $showCamera) {
            CameraPickerView(
                onImagePicked: { uiImage in
                    viewModel.setImage(uiImage)
                    showCamera = false
                },
                onCancel: {
                    showCamera = false
                }
            )
            .ignoresSafeArea()
        }
    }
}

#Preview {
    MissionProofView(
        mission: .constant(TempData.soloMission1),
        viewModel: MissionViewModel()
    )
}
