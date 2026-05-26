//
//  MapView.swift
//  CH3_Group13
//
//  Created by Muhammad Darrel Prawira on 23/05/26.
//

import MapKit
import SwiftUI
import SwiftData
import CoreLocation
import Observation
import GeoToolbox

// MARK: - Sport Category
enum SportCategory: String, CaseIterable {
    case all      = "All"
    case running  = "Running"
    case gym      = "Gym"
    case cycling  = "Cycling"
    case dining   = "Recovery"

    var systemImage: String {
        switch self {
        case .all:     return "list.bullet"
        case .running: return "figure.run"
        case .gym:     return "dumbbell.fill"
        case .cycling: return "figure.outdoor.cycle"
        case .dining:  return "fork.knife"
        }
    }

    var color: Color {
        switch self {
        case .all:     return .gray
        case .running: return .orange
        case .gym:     return .red
        case .cycling: return .green
        case .dining:  return .purple
        }
    }
}

// MARK: - Peta Utama
struct MapView: View {
    var events: [Event] = TempData.allEvents


    @State private var locationManager  = LocationManager()

    @State private var selectedEvent: Event? = nil

    private static let defaultRegion = MKCoordinateRegion(
        center: CLLocationCoordinate2D(latitude: -8.7238, longitude: 115.1752),
        span: MKCoordinateSpan(latitudeDelta: 0.08, longitudeDelta: 0.08)
    )

    @State private var cameraPosition: MapCameraPosition = .userLocation(fallback: .region(defaultRegion))
    @Namespace private var mapScope

    @State private var selectedCategory: SportCategory = .all
    @State private var searchQuery: String = ""
    @State private var isSearchFocused: Bool = false

    var filteredEvents: [Event] {
        events.filter { event in
            let matchCategory = selectedCategory == .all || event.category.contains(selectedCategory.rawValue.lowercased())
            let matchSearch   = searchQuery.isEmpty
                || event.name.localizedCaseInsensitiveContains(searchQuery)
                || event.venueName.localizedCaseInsensitiveContains(searchQuery)
            return matchCategory && matchSearch
        }
    }

    var body: some View {
        ZStack(alignment: .top) {
            Map(position: $cameraPosition, selection: $selectedEvent, scope: mapScope) {
                UserAnnotation()

                ForEach(filteredEvents) { event in
                    Annotation("", coordinate: event.coordinate, anchor: .bottom) {
                        EventAnnotationView(
                            isSelected: selectedEvent?.id == event.id,
                            event: event
                        )
                    }
                    .tag(event)
                }
            }
            .mapStyle(.standard(elevation: .realistic, showsTraffic: true))
            .mapControls {
                MapUserLocationButton()
                MapCompass()
                MapPitchToggle()
                MapScaleView()
            }
            .mapScope(mapScope)
            .ignoresSafeArea()
            .onTapGesture { isSearchFocused = false }

            TopSearchOverlay(
                searchQuery: $searchQuery,
                selectedCategory: $selectedCategory,
                isSearchFocused: $isSearchFocused,
                resultCount: filteredEvents.count
            )
        }
        .sheet(item: $selectedEvent) { event in
            EventDetailSheet(event: event)
        }
    }
}

// MARK: - Komponen Pencarian
struct TopSearchOverlay: View {
    @Binding var searchQuery: String
    @Binding var selectedCategory: SportCategory
    @Binding var isSearchFocused: Bool
    let resultCount: Int

    var body: some View {
        VStack(spacing: 0) {
            HStack(spacing: 10) {
                HStack(spacing: 8) {
                    Image(systemName: "magnifyingglass").foregroundStyle(.secondary)

                    TextField("Search events or venues...", text: $searchQuery)
                        .onTapGesture { isSearchFocused = true }
                        .submitLabel(.search)

                    if !searchQuery.isEmpty {
                        Button { withAnimation { searchQuery = "" } } label: {
                            Image(systemName: "xmark.circle.fill").foregroundStyle(.secondary)
                        }
                    }
                }
                .padding(.horizontal, 12)
                .padding(.vertical, 11)
                .background(.regularMaterial, in: RoundedRectangle(cornerRadius: 14))
                .shadow(color: .black.opacity(0.12), radius: 8, y: 3)

                if isSearchFocused || !searchQuery.isEmpty {
                    Button("Cancel") {
                        withAnimation(.easeOut(duration: 0.2)) {
                            searchQuery     = ""
                            isSearchFocused = false
                            UIApplication.shared.sendAction(
                                #selector(UIResponder.resignFirstResponder),
                                to: nil, from: nil, for: nil
                            )
                        }
                    }
                    .font(.system(size: 15))
                    .foregroundStyle(.blue)
                    .transition(.move(edge: .trailing).combined(with: .opacity))
                }
            }
            .padding(.horizontal, 16)
            .padding(.top, 12)
            .padding(.bottom, 10)

            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 10) {
                    ForEach(SportCategory.allCases, id: \.self) { cat in
                        CategoryChip(
                            category: cat,
                            isSelected: selectedCategory == cat
                        ) {
                            withAnimation(.spring(response: 0.3)) {
                                selectedCategory = cat
                            }
                        }
                    }
                }
                .padding(.horizontal, 16)
                .padding(.vertical, 10)
            }
        }
        .background(
            Rectangle()
                .fill(.ultraThinMaterial)
                .ignoresSafeArea(edges: .top)
        )
        .animation(.easeInOut(duration: 0.2), value: isSearchFocused)
    }
}

struct CategoryChip: View {
    let category: SportCategory
    let isSelected: Bool
    let action: () -> Void

    var body: some View {
        Button(action: action) {
            HStack(spacing: 6) {
                Image(systemName: category.systemImage)
                    .font(.caption.weight(.semibold))
                Text(category.rawValue)
                    .font(.caption.weight(.semibold))
            }
            .padding(.horizontal, 14)
            .padding(.vertical, 8)
            .background(isSelected ? category.color : Color(.secondarySystemBackground))
            .foregroundStyle(isSelected ? .white : .primary)
            .clipShape(Capsule())
            .shadow(color: .black.opacity(isSelected ? 0.2 : 0.08), radius: 4, y: 2)
        }
    }
}

#Preview {
    MapView()
}
