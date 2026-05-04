//
//  TrackerDetailView.swift
//  SquareGPS Test App
//
//  Created by Антон Пеньков on 01.05.2026.
//

import SwiftUI
import CoreLocation

struct TrackerDetailView: View {
    @StateObject var viewModel: TrackerDetailViewModel

    var body: some View {
        ZStack {
            LinearGradient(
                gradient: Gradient(colors: [
                    Color(red: 0.98, green: 0.91, blue: 0.96),
                    Color(red: 0.85, green: 0.94, blue: 0.99)
                ]),
                startPoint: .top,
                endPoint: .bottom
            )
            .ignoresSafeArea()

            VStack(spacing: 16) {

                // Карточка с основной инфой
                VStack(alignment: .leading, spacing: 12) {
                    Text(viewModel.tracker.label)
                        .font(.system(size: 28, weight: .bold))
                        .foregroundColor(Color(red: 0.54, green: 0.33, blue: 0.87))
                        .padding(.bottom, 6)

                    HStack {
                        Text("Model:")
                            .fontWeight(.semibold)
                            .foregroundColor(Color(red: 0.54, green: 0.33, blue: 0.87))
                        Text(viewModel.tracker.model)
                    }
                    HStack {
                        Text("Device ID:")
                            .fontWeight(.semibold)
                            .foregroundColor(Color(red: 0.33, green: 0.65, blue: 0.56))
                        Text(viewModel.tracker.deviceId)
                    }
                    if let coord = viewModel.currentCoordinate {
                        HStack {
                            Text("Coordinates:")
                                .fontWeight(.semibold)
                                .foregroundColor(.gray)
                            Text(String(format: "%.6f, %.6f", coord.latitude, coord.longitude))
                        }
                    } else if viewModel.isLoading {
                        Text("Loading coordinates...").foregroundColor(.gray)
                    } else if let err = viewModel.errorMessage {
                        Text(err)
                            .foregroundColor(.red)
                    } else {
                        Text("No coordinates for the tracker")
                            .foregroundColor(.gray)
                    }
                }
                .padding()
                .background(Color.white.opacity(0.95))
                .cornerRadius(20)
                .shadow(color: Color(.sRGBLinear, white: 0.3, opacity: 0.14), radius: 12, x: 0, y: 7)
                .padding(.horizontal)

                if let coord = viewModel.currentCoordinate {
                    TrackersMapView(coordinate: coord, trackerName: viewModel.tracker.label)
                        .frame(height: 350)
                        .background(Color.white.opacity(0.9))
                        .cornerRadius(20)
                        .shadow(color: Color(.sRGBLinear, white: 0.3, opacity: 0.10), radius: 10, x: 0, y: 7)
                        .padding(.horizontal)
                } else {
                    Rectangle()
                        .fill(Color.white.opacity(0.7))
                        .frame(height: 350)
                        .overlay(Text("No data for map").foregroundColor(.gray))
                        .cornerRadius(20)
                        .padding(.horizontal)
                }
                Spacer()
            }
        }
        .navigationTitle(viewModel.tracker.label)
        .navigationBarTitleDisplayMode(.inline)
        .onAppear { viewModel.startUpdating() }
        .onDisappear { viewModel.stopUpdating() }
    }
}

#Preview {
    let tracker = Tracker(
        id: 1, label: "Demo", model: "X1",
        deviceId: "ABC123",
        latitude: 40.7128,
        longitude: -74.0060,
        heading: 90
    )
    let viewModel = TrackerDetailViewModel(tracker: tracker)
    return TrackerDetailView(viewModel: viewModel)
}
