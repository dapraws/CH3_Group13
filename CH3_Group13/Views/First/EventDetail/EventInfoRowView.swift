//
//  EventInfoRow.swift
//  CH3_Group13
//
//  Created by Muhammad Darrel Prawira on 24/05/26.
//

import SwiftUI

struct EventInfoRowView: View {

    var event: Event

    var body: some View {
        VStack(alignment: .leading, spacing: 10) {

            HStack(spacing: 10) {
                Image(systemName: "calendar")
                    .foregroundStyle(.blue)
                Text(event.formattedDate)
                    .font(.subheadline)
            }

            HStack(spacing: 10) {
                Image(systemName: "clock")
                    .foregroundStyle(.blue)
                Text(event.formattedTime)
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
