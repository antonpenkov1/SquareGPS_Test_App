//
//  TrackerEntity+CoreDataProperties.swift
//  SquareGPS Test App
//
//  Created by Антон Пеньков on 04.05.2026.
//
//

import Foundation
import CoreData

extension TrackerEntity {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<TrackerEntity> {
        return NSFetchRequest<TrackerEntity>(entityName: "TrackerEntity")
    }

    @NSManaged public var deviceId: String?
    @NSManaged public var id: Int64
    @NSManaged public var label: String?
    @NSManaged public var model: String?
    @NSManaged public var latitude: Double
    @NSManaged public var longitude: Double
    @NSManaged public var heading: Double

}

extension TrackerEntity : Identifiable {

}
