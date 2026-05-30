//
//  EventAnnotationView.swift
//  CH3_Group13
//
//  Created by Muhammad Darrel Prawira on 23/05/26.
//

import SwiftUI

struct EventAnnotationView: View {
    var event: Event
    var viewModel: MapViewModel
    var isJoined: Bool = false
    var isCompleted: Bool = false

    private var sport: SportCategory {
        SportCategory.from(categories: event.category)
    }

    private var isSelected: Bool {
        viewModel.highlightedEventId == event.id
    }

    var body: some View {
        VStack(spacing: 0) {
            ZStack {
                // If completed, show a green ring. If joined, show a blue ring. (No theme colors)
                Circle()
                    .stroke(
                        isCompleted ? Color.green : (isJoined ? Color.yellow : .clear),
                        lineWidth: isJoined || isCompleted ? 4 : 0
                    )
                    .frame(width: 52, height: 52)
                    .opacity(isSelected ? 1 : (isJoined || isCompleted ? 0.8 : 0))

                Circle()
                    .fill(sport.color.opacity(0.25))
                    .frame(width: 66, height: 66)
                    .opacity(isSelected ? 1 : 0)
                    .scaleEffect(isSelected ? 1 : 0.4)

                Circle()
                    .fill(isCompleted ? Color.green : sport.color)
                    .frame(width: 44, height: 44)
                    .shadow(
                        color: sport.color.opacity(0.45),
                        radius: isSelected ? 10 : 5
                    )
                    .scaleEffect(isSelected ? 1.3 : 1.0)

                Image(systemName: isCompleted ? "checkmark" : sport.icon)
                    .foregroundStyle(.white)
                    .font(.system(size: 20, weight: .semibold))
                    .scaleEffect(isSelected ? 1.3 : 1.0)
            }

            Image(systemName: "arrowtriangle.down.fill")
                .font(.system(size: 10))
                .foregroundStyle(isCompleted ? Color.green : sport.color)
                .offset(y: isSelected ? -3 :-9)
        }
        .animation(.spring(response: 0.3, dampingFraction: 0.55), value: isSelected)
    }
}

#Preview("Volleyball - Default") {
    EventAnnotationView(event: TempData.event1, viewModel: MapViewModel())
}

#Preview("Running - Joined") {
    EventAnnotationView(event: TempData.event2, viewModel: MapViewModel(), isJoined: true)
}

#Preview("Basketball - Completed") {
    EventAnnotationView(event: TempData.event4, viewModel: MapViewModel(), isCompleted: true)
}
