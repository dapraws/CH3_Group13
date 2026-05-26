//
//  MapViewModel.swift
//  CH3_Group13
//
//  Created by Muhammad Darrel Prawira on 26/05/26.
//

import SwiftUI
import MapKit

@Observable
class MapViewModel {

    var events: [Event] = TempData.allEvents
    var selectedEvent: Event? = nil
    var searchText: String = ""
    var selectedCategory: SportCategory? = nil

    var position: MapCameraPosition = .region(
        MKCoordinateRegion(
            center: CLLocationCoordinate2D(latitude: -8.7184, longitude: 115.1736),
            span: MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.0)
        )
    )

    var filteredEvents: [Event] {
        events.filter { event in
            let matchesSearch = searchText.isEmpty ||
                event.name.localizedCaseInsensitiveContains(searchText)

            let matchesCategory: Bool
            if let selected = selectedCategory {
                matchesCategory = SportCategory.from(categories: event.category) == selected
            } else {
                matchesCategory = true
            }

            return matchesSearch && matchesCategory
        }
    }
}
