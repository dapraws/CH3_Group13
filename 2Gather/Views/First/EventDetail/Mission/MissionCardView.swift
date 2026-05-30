//
//  MissionCardView.swift
//  CH3_Group13
//
//  Created by Muhammad Darrel Prawira on 23/05/26.
//

import SwiftData
import SwiftUI

struct MissionCardView: View {
    @Binding var mission: Mission
    var eventId: UUID  // pass eventId instead of eventState
    var onComplete: (String) -> Void = { _ in }

    @Query private var allStates: [UserEventState]
    @State private var viewModel = MissionViewModel()

    // Now we can safely look up the right state reactively
    private var eventState: UserEventState? {
        allStates.first(where: { $0.eventId == eventId })
    }

    private var savedImage: UIImage? {
        guard let path = eventState?.proofImagePath else { return nil }
        return PhotoStorage.loadProofImage(named: path)
    }

    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text(mission.name).font(.headline)
            Text(mission.desc).font(.subheadline).foregroundStyle(.secondary)

            if eventState?.isCompleted == true {
                HStack(spacing: 12) {
                    if let image = savedImage {
                        Image(uiImage: image)
                            .resizable()
                            .scaledToFill()
                            .frame(width: 60, height: 60)
                            .clipShape(RoundedRectangle(cornerRadius: 8))
                    }
                    VStack(alignment: .leading, spacing: 4) {
                        Label("Completed", systemImage: "checkmark.circle.fill")
                            .foregroundStyle(.green)
                            .font(.subheadline)
                            .bold()
                        if let caption = eventState?.caption, !caption.isEmpty {
                            Text(caption)
                                .font(.caption)
                                .foregroundStyle(.secondary)
                                .lineLimit(1)
                        } else {
                            Text("Tap to view memory")
                                .font(.caption)
                                .foregroundStyle(.secondary)
                        }
                    }
                    Spacer()
                    Image(systemName: "chevron.right")
                        .font(.caption)
                        .foregroundStyle(.secondary)
                }
                .padding(.top, 8)
                .contentShape(Rectangle())
                .onTapGesture {
                    if savedImage != nil { viewModel.showPreview = true }
                }

            } else {
                Button("Complete Mission") {
                    viewModel.showCamera = true
                }
                .buttonStyle(.bordered)
                .padding(.top, 8)
            }
        }
        .padding()
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(Color(.systemGray6))
        .clipShape(RoundedRectangle(cornerRadius: 12))
        .fullScreenCover(isPresented: $viewModel.showCamera) {
            CustomCameraView(
                onCapture: { image in viewModel.didCapture(image) },
                onCancel: { viewModel.showCamera = false }
            )
        }
        .fullScreenCover(isPresented: $viewModel.showPreview) {
            if eventState?.isCompleted == true, let image = savedImage {
                CompletedMissionPreview(
                    image: image,
                    caption: eventState?.caption,
                    onDismiss: { viewModel.showPreview = false }
                )
            } else if let image = viewModel.capturedImage {
                ProofPreviewView(
                    image: image,
                    onSend: { caption in
                        viewModel.submitProof(
                            image: image,
                            caption: caption,
                            mission: mission,
                            eventState: eventState,
                            onComplete: onComplete
                        )
                    },
                    onRetake: { viewModel.retake() }
                )
            }
        }
    }
}

#Preview("Incomplete") {
    MissionCardView(
        mission: .constant(TempData.soloMission1),
        eventId: UUID()
    )
    .padding()
}
