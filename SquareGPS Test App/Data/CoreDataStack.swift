//
//  CoreDataStack.swift
//  SquareGPS Test App
//
//  Created by Антон Пеньков on 01.05.2026.
//

import Foundation
import CoreData

final class CoreDataStack {
    static let shared = CoreDataStack()
    let persistentContainer: NSPersistentContainer
    
    
    var managedContext: NSManagedObjectContext { persistentContainer.viewContext }
    private init() {
        persistentContainer = NSPersistentContainer(name: "SquareGPS_Test_App")
        persistentContainer.loadPersistentStores { _, error in
            if let error = error {
                fatalError("Unable to load Core Data: \(error)")
            }
        }
    }
}
