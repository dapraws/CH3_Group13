//
//  MissionCardView.swift
//  CH3_Group13
//
//  Created by Muhammad Darrel Prawira on 23/05/26.
//

import SwiftUI

struct MissionCardView: View {

    var mission: Mission

    // Called when user taps Complete
    // TODO (Darrel): wire to ViewModel
    var onComplete: () -> Void = {}

    // Controls whether MissionProofView is showing
    @State private var showProof: Bool = false

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {

            // Mission name
            Text(mission.name)
                .font(.headline)

            // Mission description
            Text(mission.desc)
                .font(.subheadline)
                .foregroundStyle(.secondary)

            // Completed or complete button
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
            MissionProofView(mission: mission, onSubmit: {
                showProof = false
                onComplete()
            })
        }
    }
}

#Preview("Incomplete") {
    MissionCardView(mission: TempData.soloMission1)
        .padding()
}

#Preview("Completed") {
    MissionCardView(mission: TempData.completedMission)
        .padding()
}
