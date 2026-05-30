//
//  MissionSectionView.swift
//  CH3_Group13
//
//  Created by Muhammad Darrel Prawira on 24/05/26.
//

import SwiftUI

struct MissionSectionView: View {

    @Binding var mission: Mission
    var isJoined: Bool
    var onJoin: () -> Void
    var onMissionComplete: (String) -> Void = { _ in }

    var body: some View {
        VStack(alignment: .leading, spacing: 12) {

            if !isJoined {
                Button {
                    withAnimation(.spring(response: 0.6, dampingFraction: 0.8))
                    {
                        onJoin()
                    }
                } label: {
                    Text("Register for Event")
                        .fontWeight(.semibold)
                        .frame(maxWidth: .infinity)
                        .padding()
                }
                .buttonStyle(.plain)
                .background(Color.blue)
                .foregroundColor(.white)
                .clipShape(RoundedRectangle(cornerRadius: 12))
                .transition(
                    .asymmetric(
                        insertion: .opacity,
                        removal: .scale(scale: 0.8).combined(with: .opacity)
                    )
                )
            }

            Divider()
            Text("Mission")
                .font(.headline)

            if isJoined {
                // UNLOCKED
                MissionCardView(
                    mission: $mission,
                    onComplete: { rewardMessage in
                        onMissionComplete(rewardMessage)
                    }
                )
                .transition(.move(edge: .bottom).combined(with: .opacity))

            } else {
                // LOCKED
                ZStack {
                    MissionCardView(mission: $mission, onComplete: { _ in })
                        .blur(radius: 4)
                        .allowsHitTesting(false)

                    VStack(spacing: 12) {
                        Image(systemName: "lock.fill")
                            .font(.largeTitle)
                            .foregroundStyle(.secondary)
                        Text("Join this event to unlock the mission")
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
                .transition(.opacity)
            }
        }
        .animation(.default, value: isJoined)
    }
}

#Preview("Locked") {
    MissionSectionView(
        mission: .constant(TempData.event1.mission),
        isJoined: false,
        onJoin: {}
    )
    .padding()
}

#Preview("Unlocked") {
    MissionSectionView(
        mission: .constant(TempData.event1.mission),
        isJoined: true,
        onJoin: {}
    )
    .padding()
}
