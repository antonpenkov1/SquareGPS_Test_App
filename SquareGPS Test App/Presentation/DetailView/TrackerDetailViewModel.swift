//
//  TrackerDetailViewModel.swift
//  SquareGPS Test App
//
//  Created by Антон Пеньков on 01.05.2026.
//

import Foundation
import Combine
import CoreLocation

final class TrackerDetailViewModel: ObservableObject {
    let tracker: Tracker
    private let apiService: ApiService

    @Published var currentCoordinate: CLLocationCoordinate2D?
    @Published var heading: Double?
    @Published var isLoading = false
    @Published var errorMessage: String?

    private var updateTimer: Timer?
    private let updateInterval: TimeInterval = 10 // секунд

    init(tracker: Tracker, apiService: ApiService = .shared) {
        self.tracker = tracker
        self.apiService = apiService
    }

    func startUpdating() {
        updateTimer?.invalidate()
        fetchCurrentStateCoordsOnce() // Первый раз сразу
        updateTimer = Timer.scheduledTimer(withTimeInterval: updateInterval, repeats: true) { [weak self] _ in
            self?.fetchCurrentStateCoordsOnce()
        }
    }
    
    func stopUpdating() {
        updateTimer?.invalidate()
        updateTimer = nil
    }

    private func fetchCurrentStateCoordsOnce() {
        guard !isLoading else { return }
        isLoading = true
        errorMessage = nil
        Task {
            do {
                let (lat, lng, heading) = try await apiService.fetchCurrentStateCoords(trackerId: tracker.id)
                await MainActor.run {
                    self.currentCoordinate = CLLocationCoordinate2D(latitude: lat, longitude: lng)
                    self.heading = heading
                    self.isLoading = false
                }
            } catch {
                await MainActor.run {
                    self.errorMessage = error.localizedDescription
                    self.isLoading = false
                }
            }
        }
    }
}
