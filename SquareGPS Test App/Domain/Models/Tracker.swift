//
//  Tracker.swift
//  SquareGPS Test App
//
//  Created by Антон Пеньков on 01.05.2026.
//
import Foundation

struct Tracker: Identifiable {
    let id: Int
    let label: String
    let model: String
    let deviceId: String
    
    var latitude: Double?
    var longitude: Double?
    var heading: Double?
    
    init(_ entity: TrackerEntity) {
        self.id = Int(entity.id)
        self.label = entity.label ?? ""
        self.model = entity.model ?? ""
        self.deviceId = entity.deviceId ?? ""
        self.latitude = entity.latitude
        self.longitude = entity.longitude
        self.heading = entity.heading
    }
    
    init(id: Int, label: String, model: String, deviceId: String, latitude: Double? = nil, longitude: Double? = nil, heading: Double? = nil) {
        self.id = id
        self.label = label
        self.model = model
        self.deviceId = deviceId
        self.latitude = latitude
        self.longitude = longitude
        self.heading = heading
    }
}
