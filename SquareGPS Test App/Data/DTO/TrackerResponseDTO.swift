//
//  TrackerResponseDTO.swift
//  SquareGPS Test App
//
//  Created by Антон Пеньков on 01.05.2026.
//

import Foundation

struct TrackerResponseDTO: Decodable {
    let success: Bool
    let list: [TrackerDTO]
    struct TrackerDTO: Decodable {
        let id: Int
        let label: String?
        let clone: Bool?
        let group_id: Int?
        let avatar_file_name: String?
        let source: SourceDTO?
        let tag_bindings: [TagBindingDTO]?
        
        struct SourceDTO: Decodable {
            let id: Int
            let device_id: String?
            let model: String?
            let blocked: Bool?
            let tariff_id: Int?
            let status_listing_id: Int?
            let creation_date: String?
            let tariff_end_date: String?
            let phone: String?
        }
        struct TagBindingDTO: Decodable {
            let tag_id: Int
            let ordinal: Int
        }
    }
}
