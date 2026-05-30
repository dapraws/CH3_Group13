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
                    UserAnnotation()

                    ForEach(viewModel.filteredEvents, id: \.id) { event in
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
                                viewModel.selectAndZoom(event)
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
            .overlay(alignment: .bottomTrailing) {
                Button {
                    viewModel.centerOnUser()
                } label: {
                    Image(systemName: "location.fill")
                        .font(.title3)
                        .foregroundStyle(.white)
                        .padding(12)
                        .background(.blue, in: Circle())
                        .shadow(radius: 4)
                }
                .padding(.trailing, 16)
                .padding(.bottom, 0)
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

#Preview {
    MapView()
}
