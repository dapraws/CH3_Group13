//
//  EventInfoRow.swift
//  CH3_Group13
//
//  Created by Muhammad Darrel Prawira on 23/05/26.
//

import SwiftUI
import MapKit
import GeoToolbox

struct EventInfoRowView: View {

    var event: Event
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            HStack {
                HStack(spacing: 10) {
                    Image(systemName: "calendar")
                        .foregroundStyle(.blue)
                    Text(event.formattedDate)
                        .font(.subheadline)
                        .fontWeight(.bold)
                }
                .padding()
                .background(Color(.systemGray6))
                .clipShape(RoundedRectangle(cornerRadius: 30))

                HStack(spacing: 10) {
                    Image(systemName: "clock")
                        .foregroundStyle(.blue)
                    Text(event.formattedTime)
                        .font(.subheadline)
                }
                .padding()
                .background(Color(.systemGray6))
                .clipShape(RoundedRectangle(cornerRadius: 30))
            }

            HStack {
                // Venue — buka di Apple Maps via GeoToolbox
                Button {
                    openInMaps()
                } label: {
                    HStack(spacing: 10) {
                        Image(systemName: "mappin.and.ellipse")
                            .foregroundStyle(.blue)

                        Text(event.venueName)
                                .font(.subheadline)
                                .foregroundStyle(.blue)
                                .lineLimit(1)
                    }
                    .padding()
                    .background(Color(.systemGray6))
                    .clipShape(RoundedRectangle(cornerRadius: 30))
                }

                HStack(spacing: 10) {
                    Image(systemName: "person.fill")
                        .foregroundStyle(.blue)
                    Text("15 Person (Max)")
                        .font(.subheadline)
                }
                .padding()
                .background(Color(.systemGray6))
                .clipShape(RoundedRectangle(cornerRadius: 30))
            }
        }
    }

    // MARK: GeoToolbox — Open venue in Apple Maps
    func openInMaps() {
        Task {
            let descriptor = PlaceDescriptor(
                representations: [.coordinate(event.coordinate)],
                commonName: event.venueName
            )
            let request = MKMapItemRequest(placeDescriptor: descriptor)
            do {
                let mapItem = try await request.mapItem
                mapItem.openInMaps()
            } catch {
                print("⚠️ Failed to fetch venue: \(error.localizedDescription)")
            }
        }
    }
}

#Preview {
    EventInfoRowView(event: TempData.event1)
        .padding()
}
