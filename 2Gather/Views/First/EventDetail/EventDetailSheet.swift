//
//  EventDetailSheet.swift
//  CH3_Group13
//
//  Created by Muhammad Darrel Prawira on 23/05/26.
//

import SwiftUI
import SwiftData

struct EventDetailSheet: View {
    
    @Environment(\.modelContext) private var modelContext
    @Query private var userStates: [UserEventState]
    
    var event: Event
    @State private var viewModel: EventDetailViewModel

    init(event: Event) {
        self.event = event
        _viewModel = State(
            initialValue: EventDetailViewModel(mission: event.mission)
        )
    }
    
    private var currentUserState: UserEventState? {
        userStates.first(where: { $0.eventId == event.id })
    }
    
    private var isJoined: Bool {
        currentUserState != nil
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

                        Text("Hosted by \(event.host)")
                            .font(.subheadline)
                            .foregroundStyle(.secondary)
                            .fontWeight(.medium)

                        Text(event.desc)
                            .fontWeight(.light)

                        EventInfoRowView(event: event)
                            .padding(.vertical, 8)

                        MissionSectionView(
                            mission: $viewModel.mission,
                            isJoined: isJoined,
                            onJoin: {
                                let newState = UserEventState(eventId: event.id)
                                modelContext.insert(newState)
                            },
                            onMissionComplete: { message in
                                if let state = currentUserState {
                                    state.isCompleted = true
                                }
                                viewModel.rewardMessage = message
                                viewModel.showReward = true
                            }
                        )
                    }
                    .padding()
                }
            }

            if viewModel.showReward {
                Color.white.opacity(0.001)
                    .ignoresSafeArea()
                    .onTapGesture {
                        viewModel.showReward = false
                    }

                MissionRewardPopup(
                    rewardMessage: viewModel.rewardMessage,
                    onDismiss: { viewModel.showReward = false }
                )
                .transition(.scale.combined(with: .opacity))
            }
        }
        .animation(.spring(duration: 0.3), value: viewModel.showReward)
        .presentationDetents([.medium, .large])
        .presentationDragIndicator(.visible)
    }
}

#Preview {
    EventDetailSheet(event: TempData.event1)
}
