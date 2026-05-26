//
//  MissionCardView.swift
//  CH3_Group13
//
//  Created by Muhammad Darrel Prawira on 23/05/26.
//

import SwiftUI

struct MissionCardView: View {

    @Binding var mission: Mission

    // TODO (Darrel): logic
    var onComplete: (String) -> Void = { _ in }

    @State private var showProof: Bool = false
    @State private var showReward: Bool = false
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {

            Text(mission.name)
                .font(.headline)

            Text(mission.desc)
                .font(.subheadline)
                .foregroundStyle(.secondary)

            if mission.isCompleted {
                Label("Completed", systemImage: "checkmark.circle.fill")
                    .foregroundStyle(.green)
                    .font(.subheadline)
            } else {
                Button("Complete Mission") {
                    showProof = true
                }
                .buttonStyle(.bordered)
            }
        }
        .padding()
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(Color(.systemGray6))
        .clipShape(RoundedRectangle(cornerRadius: 12))
        .sheet(isPresented: $showProof) {
            MissionProofView(
                mission: $mission,
                onSubmit: {
                    mission.isCompleted = true
                    showProof = false
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.4) {
                        showReward = true
                    }
                    onComplete(mission.reward)
                }
            )
        }
    }
}

#Preview("Incomplete") {
    MissionCardView(
        mission: .constant(TempData.soloMission1)
    )
    .padding()
}

#Preview("Completed") {
    MissionCardView(
        mission: .constant(TempData.completedMission)
    )
    .padding()
}
