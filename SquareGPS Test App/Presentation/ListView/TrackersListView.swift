//
//  TrackersListView.swift
//  SquareGPS Test App
//
//  Created by Антон Пеньков on 01.05.2026.
//

import SwiftUI

struct TrackersListView: View {
    @StateObject var viewModel: TrackersListViewModel

    var body: some View {
        NavigationStack {
            ZStack {
                LinearGradient(
                    gradient: Gradient(colors: [Color(red: 0.98, green: 0.91, blue: 0.96), Color(red: 0.85, green: 0.94, blue: 0.99)]),
                    startPoint: .top,
                    endPoint: .bottom
                ).ignoresSafeArea()
                
                VStack {
                    OfflineBannerView(isOffline: viewModel.isOffline, errorText: viewModel.errorText)
                    if viewModel.isLoading && viewModel.trackers.isEmpty {
                        ActivityIndicatorView()
                    } else {
                        ScrollView {
                            LazyVStack(spacing: 18) {
                                ForEach(viewModel.trackers) { tracker in
                                    NavigationLink(destination: TrackerDetailView(viewModel: TrackerDetailViewModel(tracker: tracker))) {
                                        HStack {
                                            VStack(alignment: .leading, spacing: 6) {
                                                Text(tracker.label)
                                                    .font(.headline)
                                                    .foregroundColor(Color(red: 0.52, green: 0.35, blue: 0.85))
                                                Text(tracker.model)
                                                    .font(.caption)
                                                    .foregroundColor(.gray)
                                            }
                                            Spacer()
                                            Image(systemName: "chevron.right")
                                                .foregroundColor(Color(red: 0.79, green: 0.64, blue: 0.98))
                                        }
                                        .padding()
                                        .background(Color.white.opacity(0.92))
                                        .cornerRadius(18)
                                        .shadow(color: Color(.sRGBLinear, white: 0.3, opacity: 0.10), radius: 8, x: 0, y: 5)
                                        .padding(.horizontal)
                                    }
                                    .buttonStyle(PlainButtonStyle())
                                }
                            }
                            .padding(.top, 20)
                        }
                        .refreshable {
                            viewModel.refresh()
                        }
                    }
                }
                .navigationTitle("Trackers")
            }
        }
    }
}


#Preview {
    let mockVM = TrackersListViewModel(
        getTrackersUseCase: GetTrackersUseCase(
            repository: MockTrackerRepository()
        )
    )
    mockVM.trackers = [
        Tracker(id: 1, label: "Demo 1", model: "X-1", deviceId: "ID1"),
        Tracker(id: 2, label: "Demo 2", model: "X-2", deviceId: "ID2")
    ]
    return TrackersListView(viewModel: mockVM)
}
