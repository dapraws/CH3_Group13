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
                HStack(spacing: 10) {
                    Image(systemName: "mappin.and.ellipse")
                        .foregroundStyle(.blue)
                    
                    //Connect to AppleMaps
                    Link(
                        destination: URL(
                            string: "http://maps.apple.com/?ll=\(event.latitude),\(event.longitude)"
                        )!
                    ) {
                        Text("\(event.latitude), \(event.longitude)")
                            .font(.subheadline)
                            .foregroundStyle(.blue)
                    }
                }
                .padding()
                .background(Color(.systemGray6))
                .clipShape(RoundedRectangle(cornerRadius: 30))
                
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
}

#Preview {
    EventInfoRowView(event: TempData.event1)
        .padding()
}
