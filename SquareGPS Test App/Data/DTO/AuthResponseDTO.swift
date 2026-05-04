//
//  AuthResponseDTO.swift
//  SquareGPS Test App
//
//  Created by Антон Пеньков on 01.05.2026.
//

import Foundation

struct AuthResponseDTO: Decodable {
    let hash: String?
    let success: Bool
    let errors: [String]?
}
