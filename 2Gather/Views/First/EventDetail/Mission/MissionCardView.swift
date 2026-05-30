//
//  MissionCardView.swift
//  CH3_Group13
//
//  Created by Muhammad Darrel Prawira on 23/05/26.
//

import SwiftUI

struct MissionCardView: View {
    @Binding var mission: Mission
    var eventState: UserEventState?
    var onComplete: (String) -> Void = { _ in }

    @State private var viewModel = MissionViewModel()
    @State private var showPreview = false
    
    private var savedImage: UIImage? {
        guard let path = eventState?.proofImagePath else { return nil }
        return PhotoStorage.loadProofImage(named: path)
    }

    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text(mission.name).font(.headline)
            Text(mission.desc).font(.subheadline).foregroundStyle(.secondary)

            if eventState?.isCompleted == true {
                HStack {
                    if let image = savedImage {
                        Image(uiImage: image)
                            .resizable()
                            .scaledToFill()
                            .frame(width: 60, height: 60)
                            .clipShape(RoundedRectangle(cornerRadius: 8))
                    }
                    
                    VStack(alignment: .leading) {
                        Label("Completed", systemImage: "checkmark.circle.fill")
                            .foregroundStyle(.green).font(.subheadline).bold()
                        Text("Tap to view memory")
                            .font(.caption).foregroundStyle(.secondary)
                    }
                    Spacer()
                }
                .padding(.top, 8)
                .contentShape(Rectangle())
                .onTapGesture { if savedImage != nil { showPreview = true } }
                
            } else {
                Button("Complete Mission") { viewModel.openProof() }
                    .buttonStyle(.bordered).padding(.top, 8)
            }
        }
        .padding()
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(Color(.systemGray6))
        .clipShape(RoundedRectangle(cornerRadius: 12))
        
        .sheet(isPresented: $viewModel.showProof) {
            MissionProofView(
                mission: $mission,
                viewModel: viewModel,
                onSubmit: {
                    if let uiImage = viewModel.rawUIImage {
                        if let fileName = PhotoStorage.saveProofImage(uiImage, for: mission.id) {
                            eventState?.proofImagePath = fileName
                            eventState?.caption = viewModel.captionText
                            eventState?.isCompleted = true
                            onComplete(mission.reward)
                            viewModel.showProof = false
                        }
                    }
                }
            )
        }
        .fullScreenCover(isPresented: $showPreview) {
            if let image = savedImage {
                CompletedMissionPreview(
                    image: image,
                    caption: eventState?.caption,
                    onDismiss: { showPreview = false }
                )
            }
        }
    }
}

#Preview("Incomplete") {
    MissionCardView(mission: .constant(TempData.soloMission1))
        .padding()
}

#Preview("Completed") {
    MissionCardView(mission: .constant(TempData.completedMission))
        .padding()
}
