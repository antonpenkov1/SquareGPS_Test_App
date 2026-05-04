//
//  TrackerRepositoryImpl.swift
//  SquareGPS Test App
//
//  Created by Антон Пеньков on 01.05.2026.
//

import Foundation

final class TrackerRepositoryImpl: TrackerRepository {
    private let apiService: ApiService
    private let trackerDao: TrackerDao

    init(apiService: ApiService, trackerDao: TrackerDao) {
        self.apiService = apiService
        self.trackerDao = trackerDao
    }

    func getTrackers(forceRemote: Bool) async throws -> [Tracker] {
        if !forceRemote {
            let cachedTrackers = trackerDao.fetchAll().map { Tracker($0) }
            Task.detached(priority: .background) { [apiService, trackerDao] in
                do {
                    let fresh = try await apiService.fetchTrackers()
                    await MainActor.run {
                        trackerDao.save(trackers: fresh)
                    }
                } catch {
                    print("Background refresh error in TrackerRepositoryImpl: \(error.localizedDescription)")
                }
            }
            return cachedTrackers
        } else {
            let fresh = try await apiService.fetchTrackers()
            await MainActor.run {
                trackerDao.save(trackers: fresh)
            }
            return fresh
        }
    }

    func getTracker(id: Int) -> Tracker? {
        return trackerDao.fetchAll()
            .map { Tracker($0) }
            .first { $0.id == id }
    }
}
