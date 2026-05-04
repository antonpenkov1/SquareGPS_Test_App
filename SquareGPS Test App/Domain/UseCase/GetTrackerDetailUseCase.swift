//
//  GetTrackerDetailUseCase.swift
//  SquareGPS Test App
//
//  Created by Антон Пеньков on 01.05.2026.
//

import Foundation

final class GetTrackerDetailUseCase {
    private let repository: TrackerRepository
    init(repository: TrackerRepository) { self.repository = repository }
    
    
    func execute(id: Int) -> Tracker? {
        repository.getTracker(id: id)
    }
}
