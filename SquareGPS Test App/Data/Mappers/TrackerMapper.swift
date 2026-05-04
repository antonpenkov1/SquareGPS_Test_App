//
//  TrackerMapper.swift
//  SquareGPS Test App
//
//  Created by Антон Пеньков on 01.05.2026.
//

import Foundation

struct TrackerMapper {
    static func map(dto: TrackerResponseDTO.TrackerDTO) -> Tracker {
        Tracker(
            id: dto.id,
            label: dto.label ?? "",
            model: dto.source?.model ?? "",
            deviceId: dto.source?.device_id ?? ""
        )
    }
}
