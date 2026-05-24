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

    var body: some View {
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
                            // TODO (Darrel): logic
                            isJoined = true
                        }
                    )
                }
                .padding()
            }
        }
    }
}

#Preview {
    EventDetailSheet(event: TempData.event1)
}
