//
//  CustomCameraView.swift
//  CH3_Group13
//
//  Created by Muhammad Darrel Prawira on 26/05/26.
//


import SwiftUI

struct CustomCameraView: View {
    @StateObject private var viewModel = CameraViewModel()
    var onCapture: (UIImage) -> Void = { _ in }
    var onCancel: () -> Void = {}

    @State private var showGallery = false

    var body: some View {
        ZStack {
            Color.black.ignoresSafeArea()

            CameraPreviewLayer(viewModel: viewModel)
                .ignoresSafeArea()

            VStack {
                // ── Top bar ──────────────────────────────
                HStack {
                    Button(action: onCancel) {
                        Image(systemName: "xmark")
                            .font(.system(size: 18, weight: .semibold))
                            .foregroundColor(.white)
                            .frame(width: 44, height: 44)
                            .background(Color.white.opacity(0.2), in: Circle())
                    }

                    Spacer()

                    Button(action: viewModel.toggleFlash) {
                        Image(systemName: viewModel.isFlashOn ? "bolt.fill" : "bolt.slash")
                            .font(.system(size: 18, weight: .semibold))
                            .foregroundColor(viewModel.isFlashOn ? .yellow : .white)
                            .frame(width: 44, height: 44)
                            .background(Color.white.opacity(0.2), in: Circle())
                    }
                }
                .padding(.horizontal, 20)
                .padding(.top, 16)

                Spacer()

                // ── Bottom bar ───────────────────────────
                ZStack {
                    RoundedRectangle(cornerRadius: 40)
                        .fill(.ultraThinMaterial)
                        .frame(height: 110)
                        .padding(.horizontal, 24)

                    HStack(spacing: 0) {

                        // Gallery button
                        Button(action: { showGallery = true }) {
                            ZStack {
                                RoundedRectangle(cornerRadius: 12)
                                    .fill(Color.white.opacity(0.15))
                                    .frame(width: 54, height: 54)
                                Image(systemName: "photo.on.rectangle")
                                    .font(.system(size: 22))
                                    .foregroundColor(.white)
                            }
                        }
                        .frame(maxWidth: .infinity)

                        // Shutter button
                        Button(action: viewModel.takePic) {
                            ZStack {
                                Circle()
                                    .fill(Color.white)
                                    .frame(width: 72, height: 72)
                                Circle()
                                    .stroke(Color.white.opacity(0.5), lineWidth: 4)
                                    .frame(width: 88, height: 88)
                            }
                        }
                        .frame(maxWidth: .infinity)

                        // Flip camera button
                        Button(action: viewModel.flipCamera) {
                            ZStack {
                                Circle()
                                    .fill(Color.white.opacity(0.15))
                                    .frame(width: 54, height: 54)
                                Image(systemName: "arrow.triangle.2.circlepath.camera")
                                    .font(.system(size: 22))
                                    .foregroundColor(.white)
                            }
                        }
                        .frame(maxWidth: .infinity)
                    }
                    .padding(.horizontal, 36)
                }
                .padding(.bottom, 40)
            }
        }
        .onAppear {
            viewModel.checkPermissions()
        }
        .onChange(of: viewModel.photoData) { _, newValue in
            if let data = newValue, let image = UIImage(data: data) {
                onCapture(image)
            }
        }
        .fullScreenCover(isPresented: $showGallery) {
            PhotoPickerView(
                onImagePicked: { image in
                    onCapture(image)
                    showGallery = false
                },
                onCancel: {
                    showGallery = false
                }
            )
            .ignoresSafeArea()
        }
    }
}

#Preview {
    ZStack {
        LinearGradient(
            colors: [
                Color(red: 0.1, green: 0.15, blue: 0.2),
                Color(red: 0.05, green: 0.08, blue: 0.12)
            ],
            startPoint: .top,
            endPoint: .bottom
        )
        .ignoresSafeArea()

        VStack {
            
            // ── Top bar ──────────────────────────────
            HStack {
                Image(systemName: "xmark")
                    .font(.system(size: 18, weight: .semibold))
                    .foregroundColor(.white)
                    .frame(width: 44, height: 44)
                    .background(Color.white.opacity(0.2), in: Circle())

                Spacer()

                Image(systemName: "bolt.slash")
                    .font(.system(size: 18, weight: .semibold))
                    .foregroundColor(.white)
                    .frame(width: 44, height: 44)
                    .background(Color.white.opacity(0.2), in: Circle())
            }
            .padding(.horizontal, 20)
            .padding(.top, 16)

            Spacer()

            // ── Bottom bar ───────────────────────────
            ZStack {
                RoundedRectangle(cornerRadius: 40)
                    .fill(.ultraThinMaterial)
                    .frame(height: 110)
                    .padding(.horizontal, 24)

                HStack(spacing: 0) {
                    
                    // Gallery button
                    ZStack {
                        RoundedRectangle(cornerRadius: 12)
                            .fill(Color.white.opacity(0.15))
                            .frame(width: 54, height: 54)
                        Image(systemName: "photo.on.rectangle")
                            .font(.system(size: 22))
                            .foregroundColor(.white)
                    }
                    .frame(maxWidth: .infinity)

                    // Shutter button
                    ZStack {
                        Circle().fill(Color.white).frame(width: 72, height: 72)
                        Circle().stroke(Color.white.opacity(0.5), lineWidth: 4)
                            .frame(width: 88, height: 88)
                    }
                    .frame(maxWidth: .infinity)

                    // Flip camera button
                    ZStack {
                        Circle().fill(Color.white.opacity(0.15))
                            .frame(width: 54, height: 54)
                        Image(systemName: "arrow.triangle.2.circlepath.camera")
                            .font(.system(size: 22))
                            .foregroundColor(.white)
                    }
                    .frame(maxWidth: .infinity)
                }
                .padding(.horizontal, 36)
            }
            .padding(.bottom, 40)
        }
    }
}
