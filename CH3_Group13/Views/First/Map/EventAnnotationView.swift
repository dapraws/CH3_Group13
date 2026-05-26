//
//  EventAnnotationView.swift
//  CH3_Group13
//
//  Created by Muhammad Darrel Prawira on 23/05/26.
//

import SwiftUI

struct EventAnnotationView: View {
    let isSelected: Bool
    var event: Event

    var body: some View {
        VStack(spacing: -8) {
            ZStack {
                // Glow ring — opacity + scale, bukan transition
                Circle()
                    .fill(event.tintColor.opacity(0.25))
                    .frame(width: 66, height: 66)
                    .opacity(isSelected ? 1 : 0)
                    .scaleEffect(isSelected ? 1 : 0.4)

                // Lingkaran utama — scaleEffect saja, frame tetap
                Circle()
                    .fill(event.tintColor.gradient)
                    .frame(width: 40, height: 40)
                    .shadow(
                        color: event.tintColor.opacity(0.45),
                        radius: isSelected ? 10 : 5
                    )
                    .scaleEffect(isSelected ? 1.3 : 1.0)

                // Icon — ikut scale bersama lingkaran
                Image(systemName: event.systemImage)
                    .font(.system(size: 16, weight: .bold))
                    .foregroundStyle(.white)
                    .scaleEffect(isSelected ? 1.375 : 1.0)
            }
            .frame(width: 66, height: 66) // ← fixed frame, tidak pernah berubah

            PinTail(color: event.tintColor)
                .frame(width: 12, height: 8)
        }
        .animation(
            .spring(response: 0.3, dampingFraction: 0.55, blendDuration: 0.1),
            value: isSelected
        )
    }
}

struct PinTail: Shape {
    let color: Color

    func path(in rect: CGRect) -> Path {
        var p = Path()
        p.move(to: CGPoint(x: rect.midX, y: rect.maxY))
        p.addLine(to: CGPoint(x: rect.minX, y: rect.minY))
        p.addLine(to: CGPoint(x: rect.maxX, y: rect.minY))
        p.closeSubpath()
        return p
    }
}

#Preview {
    HStack(spacing: 40) {
        EventAnnotationView(isSelected: true, event: TempData.event1)
        EventAnnotationView(isSelected: false, event: TempData.event1)
    }
    .padding()
}
