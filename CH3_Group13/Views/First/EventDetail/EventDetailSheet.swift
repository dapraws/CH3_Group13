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

    @State private var missions: [Mission]

    @State private var showReward: Bool = false
    @State private var rewardMessage: String = ""
    
    init(event: Event) {
            self.event = event
            _missions = State(initialValue: event.missions)
        }

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
                        
                        Text("The top 10 volleyball players in the world are going to be invited to this event!")
                            .fontWeight(.light)

                        HStack(alignment:.top){
                            EventInfoRowView(event: event)
                            
                        }

                        MissionSectionView(
                            missions: $missions,
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
