//
//  MissionSectionView.swift
//  CH3_Group13
//
//  Created by Muhammad Darrel Prawira on 24/05/26.
//

import SwiftUI

struct MissionSectionView: View {

    @Binding var missions: [Mission]
    var isJoined: Bool
    var onJoin: () -> Void
    var onMissionComplete: (String) -> Void = { _ in }

    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            
            if !isJoined {
                Button("Register", action: onJoin)
                                        .buttonStyle(.borderedProminent)
                                        .fontWeight(.semibold)
                                        .frame(maxWidth: .infinity, alignment: .center)
                                        .padding()
                                        .background(Color.blue)
                                        .foregroundColor(.white)
                                        .cornerRadius(12)
            }
            
            Divider()
            Text("Missions")
                .font(.headline)

            if isJoined {
                // UNLOCKED
                ForEach($missions) { $mission in
                    MissionCardView(
                        mission: $mission,
                        onComplete: {
                            rewardMessage in
                            onMissionComplete(rewardMessage)

                        }
                    )
                }
            } else {
                // LOCKED
                ZStack {
                    VStack(spacing: 12) {
                        ForEach($missions) { $mission in
                            MissionCardView(
                                mission: $mission,
                                onComplete: { _ in }
                            )
                        }
                    }
                    .blur(radius: 4)
                    .allowsHitTesting(false)  // prevents tapping through the blur

                    VStack(spacing: 12) {
                        Image(systemName: "lock.fill")
                            .font(.largeTitle)
                            .foregroundStyle(.secondary)

                        Text("Join this event to unlock missions")
                            .font(.subheadline)
                            .foregroundStyle(.secondary)
                            .multilineTextAlignment(.center)

                    }
                    .padding()
                    .background(
                        .ultraThinMaterial,
                        in: RoundedRectangle(cornerRadius: 16)
                    )
                }
            }
        }

    }
}

#Preview("Locked") {
    MissionSectionView(
        missions: .constant(TempData.event1.missions),
        isJoined: false,
        onJoin: {}
    )
    .padding()
}

#Preview("Unlocked") {
    MissionSectionView(
        missions: .constant(TempData.event1.missions),
        isJoined: true,
        onJoin: {}
    )
    .padding()
}
