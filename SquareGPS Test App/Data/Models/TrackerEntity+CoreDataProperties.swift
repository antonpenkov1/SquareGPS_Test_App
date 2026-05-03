//
//  TrackerEntity+CoreDataProperties.swift
//  SquareGPS Test App
//
//  Created by Антон Пеньков on 01.05.2026.
//
//

public import Foundation
public import CoreData


public typealias TrackerEntityCoreDataPropertiesSet = NSSet

extension TrackerEntity {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<TrackerEntity> {
        return NSFetchRequest<TrackerEntity>(entityName: "TrackerEntity")
    }

    @NSManaged public var id: Int64
    @NSManaged public var label: String?
    @NSManaged public var model: String?
    @NSManaged public var deviceId: String?
    @NSManaged public var latitude: Double
    @NSManaged public var longitude: Double
    @NSManaged public var heading: Double

}

extension TrackerEntity : Identifiable {

}
