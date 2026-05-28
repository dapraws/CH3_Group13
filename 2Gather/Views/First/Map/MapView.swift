//
//  MapView.swift
//  CH3_Group13
//
//  Created by Muhammad Darrel Prawira on 23/05/26.
//

import MapKit
import SwiftUI

struct MapView: View {

    @State private var viewModel = MapViewModel()
    @Namespace private var mapScope

    var body: some View {
        NavigationStack {
            ZStack(alignment: .top) {

                Map(position: $viewModel.position) {
                    ForEach(viewModel.filteredEvents) { event in
                        Annotation(
                            "",
                            coordinate: CLLocationCoordinate2D(
                                latitude: event.latitude,
                                longitude: event.longitude
                            )
                        ) {
                            EventAnnotationView(
                                event: event,
                                viewModel: viewModel
                            )
                            .onTapGesture {
                                viewModel.selectEvent(event)
                            }
                        }
                    }
                }
                .ignoresSafeArea()
                .sheet(
                    item: $viewModel.selectedEvent,
                    onDismiss: {
                        viewModel.deselectEvent()
                    }
                ) { event in
                    EventDetailSheet(event: event)
                }

                ScrollView(.horizontal, showsIndicators: false) {
                    HStack(spacing: 8) {
                        FilterChip(
                            label: "All",
                            icon: "square.grid.2x2",
                            color: .gray,
                            isSelected: viewModel.selectedCategory == nil
                        ) {
                            viewModel.selectedCategory = nil
                        }
                        ForEach(SportCategory.allCases, id: \.self) {
                            category in
                            if category != .other {
                                FilterChip(
                                    label: category.label,
                                    icon: category.icon,
                                    color: category.color,
                                    isSelected: viewModel.selectedCategory
                                        == category
                                ) {
                                    if viewModel.selectedCategory == category {
                                        viewModel.selectedCategory = nil
                                    } else {
                                        viewModel.selectedCategory = category
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
            .searchable(
                text: $viewModel.searchText,
                placement: .navigationBarDrawer(displayMode: .always),
                prompt: "Search events...",
            )
        }
        .onAppear {
            viewModel.locationManager.requestPermission()
            viewModel.locationManager.startUpdating()
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
                viewModel.centerOnUser()
            }
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
