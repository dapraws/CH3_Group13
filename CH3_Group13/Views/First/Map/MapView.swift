//
//  MapView.swift
//  CH3_Group13
//
//  Created by Muhammad Darrel Prawira on 23/05/26.
//

import SwiftUI
import MapKit

struct MapView: View {
    var events: [Event] = TempData.allEvents

    @State private var selectedEvent: Event? = nil

    @State private var region = MKCoordinateRegion(
        center: CLLocationCoordinate2D(latitude: -8.6500, longitude: 115.2167),
        span: MKCoordinateSpan(latitudeDelta: 0.5, longitudeDelta: 0.5)
    )

    var body: some View {
        Map(coordinateRegion: $region, annotationItems: events) { event in
            MapAnnotation(
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
        .ignoresSafeArea()
        .sheet(item: $selectedEvent) { event in
            EventDetailSheet(event: event)
        }
    }
}

#Preview {
    MapView()
}
