//
//  MapView.swift
//  CH3_Group13
//
//  Created by Muhammad Darrel Prawira on 23/05/26.
//

import MapKit
import SwiftUI

struct MapView: View {
    
    @State private var events: [Event] = TempData.allEvents
    @State private var selectedEvent: Event? = nil
    @State private var searchText: String = ""
    @State private var selectedCategory: SportCategory? = nil
    
    @State private var position: MapCameraPosition = .region(
        MKCoordinateRegion(
            center: CLLocationCoordinate2D(latitude: -8.7184, longitude: 115.1736),
            span: MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.0)
        )
    )
    
    private var filteredEvents: [Event] {
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
    
    var body: some View {
        NavigationStack {
            ZStack(alignment: .top) {
                
                Map(position: $position) {
                    ForEach(filteredEvents) { event in
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
                
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack(spacing: 8) {
                        FilterChip(
                            label: "All",
                            icon: "square.grid.2x2",
                            color: .gray,
                            isSelected: selectedCategory == nil
                        ) {
                            selectedCategory = nil
                        }
                        ForEach(SportCategory.allCases, id: \.self) { category in
                            if category != .other {
                                FilterChip(
                                    label: category.label,
                                    icon: category.icon,
                                    color: category.color,
                                    isSelected: selectedCategory == category
                                ) {
                                    if selectedCategory == category {
                                        selectedCategory = nil
                                    } else {
                                        selectedCategory = category
                                    }
                                }
                            }
                        }
                    }
                    .padding(.horizontal)
                }
                .padding(.top, -5)
            }
            .navigationTitle("Explore")
            .navigationBarTitleDisplayMode(.inline)
            .searchable(text: $searchText, placement: .navigationBarDrawer(displayMode: .always),prompt: "Search events...", )
        }
    }
}

private struct FilterChip: View {
    var label: String
    var icon: String
    var color: Color
    var isSelected: Bool
    var onTap: () -> Void
    
    var body: some View {
        Button(action: onTap) {
            HStack(spacing: 6) {
                Image(systemName: icon)
                    .font(.system(size: 12, weight: .semibold))
                Text(label)
                    .font(.caption)
                    .fontWeight(.semibold)
            }
            .padding(.horizontal, 12)
            .padding(.vertical, 8)
            .background(isSelected ? color : Color(.systemGray6))
            .foregroundStyle(isSelected ? .white : .primary)
            .clipShape(Capsule())
        }
    }
}

#Preview {
    MapView()
}
