//
//  EventAnnotationView.swift
//  CH3_Group13
//
//  Created by Muhammad Darrel Prawira on 23/05/26.
//

import SwiftUI

struct EventAnnotationView: View {

    var event: Event

    // Derives the sport category from the event's category tags
    private var sport: SportCategory {
        SportCategory.from(categories: event.category)
    }

    var body: some View {
        VStack(spacing: 0) {
            ZStack {
                Circle()
                    .fill(sport.color)
                    .frame(width: 44, height: 44)
                    .shadow(color: sport.color.opacity(0.4), radius: 4, x: 0, y: 2)

                Image(systemName: sport.icon)
                    .foregroundStyle(.white)
                    .font(.system(size: 20, weight: .semibold))
            }

            Image(systemName: "arrowtriangle.down.fill")
                .font(.system(size: 10))
                .foregroundStyle(sport.color)
                .offset(y: -3)
        }
    }
}

#Preview("Volleyball") {
    EventAnnotationView(event: TempData.event1)
}

#Preview("Running") {
    EventAnnotationView(event: TempData.event2)
}

#Preview("Basketball") {
    EventAnnotationView(event: TempData.event4)
}
