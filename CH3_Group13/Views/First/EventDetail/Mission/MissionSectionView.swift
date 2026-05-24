//
//  MissionSectionView.swift
//  CH3_Group13
//
//  Created by Muhammad Darrel Prawira on 24/05/26.
//

import SwiftUI

struct MissionSectionView: View {

    var missions: [Mission]
    var isJoined: Bool
    var onJoin: () -> Void

    var body: some View {
        VStack(alignment: .leading, spacing: 12) {

            Text("Missions")
                .font(.headline)

            if isJoined {
                // UNLOCKED
                ForEach(missions) { mission in
                    MissionCardView(mission: mission, onComplete: {
                        // TODO (Darrel): logic
                    })
                }
            } else {
                // LOCKED
                ZStack {
                    VStack(spacing: 12) {
                        ForEach(missions) { mission in
                            MissionCardView(mission: mission, onComplete: {})
                        }
                    }
                    .blur(radius: 4)
                    .allowsHitTesting(false) // prevents tapping through the blur

                    VStack(spacing: 12) {
                        Image(systemName: "lock.fill")
                            .font(.largeTitle)
                            .foregroundStyle(.secondary)

                        Text("Join this event to unlock missions")
                            .font(.subheadline)
                            .foregroundStyle(.secondary)
                            .multilineTextAlignment(.center)

                        Button("Join Event", action: onJoin)
                            .buttonStyle(.borderedProminent)
                    }
                    .padding()
                    .background(.ultraThinMaterial, in: RoundedRectangle(cornerRadius: 16))
                }
            }
        }
    }
}

#Preview("Locked") {
    MissionSectionView(
        missions: TempData.event1.missions,
        isJoined: false,
        onJoin: {}
    )
    .padding()
}

#Preview("Unlocked") {
    MissionSectionView(
        missions: TempData.event1.missions,
        isJoined: true,
        onJoin: {}
    )
    .padding()
}
