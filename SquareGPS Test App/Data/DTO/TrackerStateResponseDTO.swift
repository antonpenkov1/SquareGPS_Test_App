//
//  TrackerStateResponseDTO.swift
//  SquareGPS Test App
//
//  Created by Антон Пеньков on 01.05.2026.
//

import Foundation

struct TrackerStateResponseDTO: Decodable {
    let user_time: String?
    let state: State
    let success: Bool

    struct State: Decodable {
        let source_id: Int?
        let gps: GPS?
    }

    struct GPS: Decodable {
        let updated: String?
        let signal_level: Int?
        let location: Location?
        let heading: Double?
        let speed: Double?
        let alt: Double?
    }

    struct Location: Decodable {
        let lat: Double
        let lng: Double
    }
}
