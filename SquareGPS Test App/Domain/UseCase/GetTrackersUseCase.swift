//
//  GetTrackersUseCase.swift
//  SquareGPS Test App
//
//  Created by Антон Пеньков on 01.05.2026.
//

import Foundation

final class GetTrackersUseCase {
    private let repository: TrackerRepository
    init(repository: TrackerRepository) { self.repository = repository }
    
    func execute(forceRemote: Bool) async throws -> [Tracker] {
        return try await repository.getTrackers(forceRemote: forceRemote)
    }
}
