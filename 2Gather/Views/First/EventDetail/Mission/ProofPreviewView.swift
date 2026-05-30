//
//  ProofPreviewView.swift
//  2Gather
//
//  Created by Muhammad Darrel Prawira on 30/05/26.
//

import SwiftUI

struct ProofPreviewView: View {
    var image: UIImage
    var onSend: (String) -> Void
    var onRetake: () -> Void

    @State private var caption: String = ""
    @FocusState private var captionFocused: Bool

    var body: some View {
        ZStack {
            Color.black.ignoresSafeArea()

            // Full screen photo
            Image(uiImage: image)
                .resizable()
                .scaledToFit()
                .ignoresSafeArea()

            VStack {
                // Top bar — retake button
                HStack {
                    Button(action: onRetake) {
                        Image(systemName: "arrow.uturn.left")
                            .font(.system(size: 18, weight: .semibold))
                            .foregroundColor(.white)
                            .frame(width: 44, height: 44)
                            .background(Color.white.opacity(0.2), in: Circle())
                    }
                    Spacer()
                }
                .padding(.horizontal, 20)
                .padding(.top, 16)

                Spacer()

                // Bottom bar — caption + send
                HStack(spacing: 12) {
                    TextField("Add a caption...", text: $caption)
                        .focused($captionFocused)
                        .padding(.horizontal, 16)
                        .padding(.vertical, 10)
                        .background(.ultraThinMaterial, in: Capsule())
                        .foregroundColor(.white)

                    Button(action: { onSend(caption) }) {
                        Image(systemName: "paperplane.fill")
                            .font(.system(size: 20, weight: .semibold))
                            .foregroundColor(.white)
                            .frame(width: 52, height: 52)
                            .background(Color.blue, in: Circle())
                    }
                }
                .padding(.horizontal, 20)
                .padding(.bottom, 20)
            }
        }
        .onTapGesture {
            captionFocused = false
        }
    }
}

#Preview {
    ProofPreviewView(
        image: UIImage(systemName: "photo")!,
        onSend: { caption in print("Sent: \(caption)") },
        onRetake: { print("Retake") }
    )
}
