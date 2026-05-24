//
//  EventInfoRow.swift
//  CH3_Group13
//
//  Created by Muhammad Darrel Prawira on 24/05/26.
//

import SwiftUI

struct EventInfoRowView: View {

    var event: Event

    private var dateText: String {
        let formatter = DateFormatter()
        formatter.dateStyle = .full
        formatter.timeStyle = .none
        return formatter.string(from: event.date)
    }

    private var timeText: String {
        let formatter = DateFormatter()
        formatter.dateStyle = .none
        formatter.timeStyle = .short
        return formatter.string(from: event.date)
    }

    var body: some View {
        VStack(alignment: .leading, spacing: 10) {

            HStack(spacing: 10) {
                Image(systemName: "calendar")
                    .foregroundStyle(.blue)
                Text(dateText)
                    .font(.subheadline)
            }

            HStack(spacing: 10) {
                Image(systemName: "clock")
                    .foregroundStyle(.blue)
                Text(timeText)
                    .font(.subheadline)
            }

            HStack(spacing: 10) {
                Image(systemName: "mappin.and.ellipse")
                    .foregroundStyle(.blue)
                Text("\(event.latitude), \(event.longitude)")
                    .font(.subheadline)
                    .foregroundStyle(.secondary)
            }
        }
    }
}

#Preview {
    EventInfoRowView(event: TempData.event1)
        .padding()
}
