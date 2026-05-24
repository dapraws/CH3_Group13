//
//  MapView.swift
//  CH3_Group13
//
//  Created by Muhammad Darrel Prawira on 23/05/26.
//

import MapKit
import SwiftUI

struct MapView: View {
    var events: [Event] = TempData.allEvents

    @State private var selectedEvent: Event? = nil

    @State private var position: MapCameraPosition = .region(
        MKCoordinateRegion(
            center: CLLocationCoordinate2D(
                latitude: -8.7238,
                longitude: 115.1752
            ),
            span: MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.0)
        )
    )

    var body: some View {
        Map(position: $position) {
            ForEach(events) { event in
                Annotation(
                    "",
                    coordinate: CLLocationCoordinate2D(
                        latitude: event.latitude,
                        longitude: event.longitude
                    )
                ) {
                    EventAnnotationView(event: event)
                        .onTapGesture {
                            selectedEvent = event
                        }
                }
            }
        }
        .ignoresSafeArea()
        .sheet(item: $selectedEvent) { event in
            EventDetailSheet(event: event)
        }
    }
}

#Preview {
    MapView()
}
