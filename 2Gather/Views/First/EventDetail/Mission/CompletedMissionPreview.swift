//
//  CompletedMissionPreview.swift
//  CH3_Group13
//
//  Created by Muhammad Darrel Prawira on 26/05/26.
//

import SwiftUI

struct CompletedMissionPreview: View {
    var image: UIImage
    var caption: String?
    var onDismiss: () -> Void

    var body: some View {
        ZStack {
            Color.black.ignoresSafeArea()
            
            VStack {
                HStack {
                    Spacer()
                    Button(action: onDismiss) {
                        Image(systemName: "xmark")
                            .font(.system(size: 18, weight: .semibold))
                            .foregroundColor(.white)
                            .frame(width: 44, height: 44)
                            .background(Color.white.opacity(0.2), in: Circle())

                    }
                    .padding()
                }
                Spacer()
            }
            .zIndex(1)

            ZStack(alignment: .bottom) {
                Image(uiImage: image)
                    .resizable()
                    .background()
                    .scaledToFit()
                    .ignoresSafeArea()

                if let caption = caption, !caption.isEmpty {
                    Text(caption)
                        .font(.body)
                        .foregroundColor(.white)
                        .padding()
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .background(Color.white.opacity(0.15))
                        .clipShape(RoundedRectangle(cornerRadius: 12))
                        .padding(.horizontal)
                }
            }
        }
    }
}

#Preview {
    CompletedMissionPreview(
        image: UIImage(systemName: "figure.volleyball")?.withTintColor(.red) ?? UIImage(),
        caption: "Caught the perfect spike! 🏐",
        onDismiss: {}
    )
}

#Preview("No Caption") {
    CompletedMissionPreview(
        image: UIImage(systemName: "figure.run") ?? UIImage(),
        caption: nil,
        onDismiss: {}
    )
}

#Preview("With Asset Image") {
    CompletedMissionPreview(
        image: UIImage(named: "volleyball-bali") ?? UIImage(),
        caption: "Caught the perfect spike! 🏐",
        onDismiss: {}
    )
}
