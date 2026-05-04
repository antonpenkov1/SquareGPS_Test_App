//
//  MockTrackerRepository.swift
//  SquareGPS Test App
//
//  Created by Антон Пеньков on 01.05.2026.
//

final class MockTrackerRepository: TrackerRepository {
    func getTrackers(forceRemote: Bool) async throws -> [Tracker] {
        [
            Tracker(id: 1, label: "Demo One", model: "XOne", deviceId: "D-1"),
            Tracker(id: 2, label: "Demo Two", model: "XTwo", deviceId: "D-2")
        ]
    }
    func getTracker(id: Int) -> Tracker? {
        Tracker(id: id, label: "Demo (id)", model: "X(id)", deviceId: "D-(id)")
    }
}
