//
//  TrackerDao.swift
//  SquareGPS Test App
//
//  Created by Антон Пеньков on 01.05.2026.
//

import Foundation
import CoreData

final class TrackerDao {
    private let context: NSManagedObjectContext
    
    
    init(coreDataStack: CoreDataStack) {
        self.context = coreDataStack.managedContext
    }
    
    func fetchAll() -> [TrackerEntity] {
        
        let request: NSFetchRequest<TrackerEntity> = TrackerEntity.fetchRequest()
        do {
            return try context.fetch(request)
        } catch {
            print("TrackerDao fetchAll error: \(error)")
            return []
        }
        
    }
    
    func save(trackers: [Tracker]) {
        let existing = fetchAll()
        existing.forEach { context.delete($0) }
        trackers.forEach {
            let entity = TrackerEntity(context: context)
            entity.id = Int64($0.id)
            entity.label = $0.label
            entity.model = $0.model
            entity.deviceId = $0.deviceId
        }
        context.saveIfNeeded()
    }
}
