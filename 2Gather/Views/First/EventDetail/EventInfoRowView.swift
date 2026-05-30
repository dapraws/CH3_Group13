//
//  EventInfoRow.swift
//  CH3_Group13
//
//  Created by Muhammad Darrel Prawira on 24/05/26.
//

import SwiftUI

struct EventInfoRowView: View {

    var event: Event

    private let columns = [
        GridItem(.flexible(), spacing: 10),
        GridItem(.flexible(), spacing: 10),
    ]

    var body: some View {
        LazyVGrid(columns: columns, spacing: 10) {

            HStack(spacing: 8) {
                Image(systemName: "calendar").foregroundStyle(.blue)
                Text(event.formattedDate).font(.subheadline).fontWeight(.bold)
                    .lineLimit(1)
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding()
            .background(Color(.systemGray6))
            .clipShape(RoundedRectangle(cornerRadius: 16))

            HStack(spacing: 8) {
                Image(systemName: "clock").foregroundStyle(.blue)
                Text(event.formattedTime).font(.subheadline).lineLimit(1)
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding()
            .background(Color(.systemGray6))
            .clipShape(RoundedRectangle(cornerRadius: 16))

            Link(
                destination: URL(
                    string:
                        "http://maps.apple.com/?ll=\(event.latitude),\(event.longitude)"
                )!
            ) {
                HStack(spacing: 8) {
                    Image(systemName: "mappin.and.ellipse").foregroundStyle(
                        .blue
                    )
                    Text(event.venueName).font(.subheadline).foregroundStyle(
                        .blue
                    ).lineLimit(1)
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding()
                .background(Color(.systemGray6))
                .clipShape(RoundedRectangle(cornerRadius: 16))
            }

            HStack(spacing: 8) {
                Image(systemName: "person.fill").foregroundStyle(.blue)
                Text("15 Max").font(.subheadline).lineLimit(1)
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding()
            .background(Color(.systemGray6))
            .clipShape(RoundedRectangle(cornerRadius: 16))
        }
    }
}

#Preview {
    EventInfoRowView(event: TempData.event1)
        .padding()
}
