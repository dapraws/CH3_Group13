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

    private var sport: SportCategory {
        SportCategory.from(categories: event.category)
    }

    private var isSelected: Bool {
        viewModel.highlightedEventId == event.id
    }

    var body: some View {
        VStack(spacing: 0) {
            ZStack {
                Circle()
                    .fill(sport.color.opacity(0.25))
                    .frame(width: 66, height: 66)
                    .opacity(isSelected ? 1 : 0)
                    .scaleEffect(isSelected ? 1 : 0.4)

                Circle()
                    .fill(sport.color)
                    .frame(width: 44, height: 44)
                    .shadow(
                        color: sport.color.opacity(0.45),
                        radius: isSelected ? 10 : 5
                    )
                    .scaleEffect(isSelected ? 1.3 : 1.0)

                Image(systemName: sport.icon)
                    .foregroundStyle(.white)
                    .font(.system(size: 20, weight: .semibold))
                    .scaleEffect(isSelected ? 1.3 : 1.0)
            }

            Image(systemName: "arrowtriangle.down.fill")
                .font(.system(size: 10))
                .foregroundStyle(sport.color)
                .offset(y: isSelected ? -3 :-9)
        }
        .animation(
            .spring(response: 0.3, dampingFraction: 0.55, blendDuration: 0.1),
            value: isSelected
        )
    }
}

#Preview("Volleyball") {
    EventAnnotationView(event: TempData.event1, viewModel: MapViewModel())
}

#Preview("Running") {
    EventAnnotationView(event: TempData.event2, viewModel: MapViewModel())
}

#Preview("Basketball") {
    EventAnnotationView(event: TempData.event4, viewModel: MapViewModel())
}
