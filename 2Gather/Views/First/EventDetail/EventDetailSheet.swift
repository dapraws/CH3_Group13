import SwiftUI

struct EventDetailSheet: View {

    var event: Event
    @State private var viewModel: EventDetailViewModel

    init(event: Event) {
        self.event = event
        _viewModel = State(
            initialValue: EventDetailViewModel(mission: event.mission)
        )
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

                        // NEW: Added Host Name
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
                            isJoined: viewModel.isJoined,
                            onJoin: {
                                viewModel.isJoined = true
                            },
                            onMissionComplete: { message in
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
