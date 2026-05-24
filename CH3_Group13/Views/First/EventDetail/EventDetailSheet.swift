//
//  EventDetailSheet.swift
//  CH3_Group13
//
//  Created by Muhammad Darrel Prawira on 23/05/26.
//

import SwiftUI

struct EventDetailSheet: View {

    var event: Event

    @State private var isJoined: Bool = false

    @State private var showReward: Bool = false
    @State private var rewardMessage: String = ""

    var body: some View {
        ZStack {
            ScrollView {
                VStack(alignment: .leading, spacing: 0) {

                    EventPhotoView(photoPath: event.photoPath)

                    VStack(alignment: .leading, spacing: 16) {

                        ScrollView(.horizontal, showsIndicators: false) {
                            HStack(spacing: 8) {
                                ForEach(event.category, id: \.self) { tag in
                                    Text(tag)
                                        .font(.caption)
                                        .padding(.horizontal, 10)
                                        .padding(.vertical, 4)
                                        .background(Color.blue.opacity(0.1))
                                        .foregroundStyle(Color.blue)
                                        .clipShape(Capsule())
                                }
                            }
                        }

                        Text(event.name)
                            .font(.title2)
                            .bold()

                        EventInfoRowView(event: event)

                        Divider()

                        MissionSectionView(
                            missions: event.missions,
                            isJoined: isJoined,
                            onJoin: {
                                isJoined = true
                            },
                            onMissionComplete: { message in
                                rewardMessage = message
                                showReward = true
                            }
                        )
                    }
                    .padding()
                }
            }
            if showReward {
                Color.white.opacity(0)
                    .ignoresSafeArea()
                    .onTapGesture {
                        showReward = false
                    }

                MissionRewardPopup(
                    rewardMessage: rewardMessage,
                    onDismiss: {
                        showReward = false
                    }
                )
                .transition(.scale.combined(with: .opacity))
            }
        }
        .animation(.spring(duration: 0.3), value: showReward)
        .presentationDetents([.medium, .large])
        .presentationDragIndicator(.visible)
    }
}

#Preview {
    EventDetailSheet(event: TempData.event1)
}
