//
//  TrackerRepository.swift
//  SquareGPS Test App
//
//  Created by Антон Пеньков on 01.05.2026.
//

import Foundation

protocol TrackerRepository {
    func getTrackers(forceRemote: Bool) async throws -> [Tracker]
    func getTracker(id: Int) -> Tracker?
}
