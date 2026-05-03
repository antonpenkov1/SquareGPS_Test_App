//
//  TrackersListViewModel.swift
//  SquareGPS Test App
//
//  Created by Антон Пеньков on 01.05.2026.
//

import Foundation
import Combine

final class TrackersListViewModel: ObservableObject {
    @Published var trackers: [Tracker] = []
    @Published var isLoading = false
    @Published var isOffline = false
    @Published var errorText: String?
    
    private let getTrackersUseCase: GetTrackersUseCase
    
    private var didInitialLoad = false

    init(getTrackersUseCase: GetTrackersUseCase) {
        self.getTrackersUseCase = getTrackersUseCase
        initialLoad()
    }
    
    func initialLoad() {
        if didInitialLoad { return }
        didInitialLoad = true
        fetchTrackers(forceRemote: false)
    }
    
    func refresh() {
        fetchTrackers(forceRemote: true)
    }

    private func fetchTrackers(forceRemote: Bool) {
        isLoading = true
        Task { [weak self] in
            guard let self = self else { return }
            do {
                let data = try await self.getTrackersUseCase.execute(forceRemote: forceRemote)
                DispatchQueue.main.async {
                    self.trackers = data
                    self.errorText = nil
                    self.isOffline = false
                    self.isLoading = false
                }
            } catch {
                DispatchQueue.main.async {
                    self.errorText = error.localizedDescription
                    self.isOffline = true
                    self.isLoading = false
                }
            }
        }
    }
}
