//
//  EventAnnotationView.swift
//  CH3_Group13
//
//  Created by Muhammad Darrel Prawira on 23/05/26.
//

import SwiftUI

struct EventAnnotationView: View {

    var event: Event

    var body: some View {
        VStack(spacing: 4) {
            ZStack {
                Circle()
                    .fill(Color.blue)
                    .frame(width: 40, height: 40)

                Image(systemName: "figure.run")
                    .foregroundStyle(.white)
                    .font(.system(size: 18))
            }
            Image(systemName: "arrowtriangle.down.fill")
                .font(.system(size: 10))
                .foregroundStyle(Color.blue)
                .offset(y: -4)
        }
    }
}

#Preview {
    EventAnnotationView(event: TempData.event1)
}
