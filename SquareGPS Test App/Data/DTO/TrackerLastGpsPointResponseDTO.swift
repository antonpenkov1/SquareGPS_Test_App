//
//  TrackerLastGpsPointResponseDTO.swift
//  SquareGPS Test App
//
//  Created by Антон Пеньков on 01.05.2026.
//

import Foundation

struct TrackerLastGpsPointResponseDTO: Decodable {
    struct Value: Decodable {
        let get_time: String?
        let heading: Double?
        let lat: Double
        let lng: Double
    }
    let success: Bool
    let value: Value
}
