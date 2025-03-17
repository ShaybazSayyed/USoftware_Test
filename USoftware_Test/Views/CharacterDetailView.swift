//
//  CharacterDetailView.swift
//  USoftware_Test
//Test
//  Created by Shaybaz Sayyed on 13/03/25.
//
import SwiftUI

struct CharacterDetailView: View {
    @ObservedObject var viewModel: CharacterDetailViewModel
    @State private var imageLoaded = false
    @State private var bubblePositions: [CGPoint] = []

    var body: some View {
        ZStack {
            // Background Bubbles Animation
            BackgroundBubbles()

            VStack(spacing: 24) {
                Spacer(minLength: 10)

                // Profile Image with Gradient Background
                ZStack {
                    Circle()
                        .fill(LinearGradient(
                            gradient: Gradient(colors: [Color.blue.opacity(0.2), Color.purple.opacity(0.2)]),
                            startPoint: .topLeading,
                            endPoint: .bottomTrailing
                        ))
                        .frame(width: 200, height: 200)
                        .shadow(color: .gray.opacity(0.3), radius: 5, x: 0, y: 4)

                    if #available(iOS 15.0, *) {
                        AsyncImage(url: URL(string: viewModel.character.image)) { image in
                            image.resizable()
                                .scaledToFit()
                                .frame(width: 180, height: 180)
                                .clipShape(Circle())
                                .overlay(Circle().stroke(Color.white, lineWidth: 3))
                                .scaleEffect(imageLoaded ? 1 : 0.8)
                                .animation(.spring(response: 0.5, dampingFraction: 0.6), value: imageLoaded)
                                .onAppear {
                                    imageLoaded = true
                                }
                        } placeholder: {
                            ProgressView()
                        }
                    } else {
                        // Fallback on earlier versions
                    }
                }

                // Name
                Text(viewModel.character.name)
                    .font(.system(size: 32, weight: .heavy, design: .rounded))
                    .foregroundColor(.primary)

                // Species Card
                Text(viewModel.character.species)
                    .font(.headline)
                    .padding(.horizontal, 20)
                    .padding(.vertical, 8)
                    .background(Color(.systemGray6))
                    .clipShape(RoundedRectangle(cornerRadius: 12))
                    .shadow(color: .gray.opacity(0.2), radius: 2, x: 0, y: 2)

                // Status Badge
                Text(viewModel.character.status)
                    .font(.headline)
                    .padding(.horizontal, 20)
                    .padding(.vertical, 8)
                    .background(statusColor(viewModel.character.status).opacity(0.2))
                    .clipShape(Capsule())
                    .foregroundColor(statusColor(viewModel.character.status))
                    .scaleEffect(viewModel.character.status == "Alive" ? 1.1 : 1.0)
                    .animation(.easeInOut(duration: 0.3), value: viewModel.character.status)

                Spacer()
            }
            .padding()
        }
        .navigationTitle("Details")
        .navigationBarTitleDisplayMode(.inline)
    }

    // Function to determine status color
    private func statusColor(_ status: String) -> Color {
        switch status.lowercased() {
        case "alive":
            return .green
        case "dead":
            return .red
        default:
            return .gray
        }
    }
}

// MARK: - Animated Background Bubbles
struct BackgroundBubbles: View {
    @State private var positions: [CGPoint] = (0..<10).map { _ in
        CGPoint(x: CGFloat.random(in: 0...UIScreen.main.bounds.width),
                y: CGFloat.random(in: 0...UIScreen.main.bounds.height))
    }

    var body: some View {
        GeometryReader { geometry in
            ZStack {
                ForEach(0..<10, id: \.self) { index in
                    Circle()
                        .fill(LinearGradient(
                            gradient: Gradient(colors: [Color.blue.opacity(0.2), Color.white.opacity(0.2)]),
                            startPoint: .topLeading,
                            endPoint: .bottomTrailing
                        ))
                        .frame(width: CGFloat.random(in: 30...80), height: CGFloat.random(in: 30...80))
                        .position(positions[index])
                        .opacity(0.6)
                        .blur(radius: 5)
                        .onAppear {
                            moveBubble(index: index, in: geometry.size)
                        }
                }
            }
            .ignoresSafeArea()
        }
    }

    private func moveBubble(index: Int, in size: CGSize) {
        withAnimation(Animation.easeInOut(duration: Double.random(in: 4...6)).repeatForever(autoreverses: true)) {
            positions[index] = CGPoint(x: CGFloat.random(in: 0...size.width),
                                       y: CGFloat.random(in: 0...size.height))
        }
    }
}
