//
//  TrackersMapView.swift
//  SquareGPS Test App
//
//  Created by Антон Пеньков on 01.05.2026.
//

import SwiftUI
import MapKit
import CoreLocation

struct TrackersMapView: View {
    let coordinate: CLLocationCoordinate2D
    let trackerName: String      // Добавь это, если тебе нужно имя в маркере

    @State private var cameraPosition: MapCameraPosition

    init(coordinate: CLLocationCoordinate2D, trackerName: String) {
        self.coordinate = coordinate
        self.trackerName = trackerName
        _cameraPosition = State(
            wrappedValue: .region(
                MKCoordinateRegion(
                    center: coordinate,
                    span: MKCoordinateSpan(latitudeDelta: 0.012, longitudeDelta: 0.012)
                )
            )
        )
    }

    // Proxy String to force map recentering when coordinate changes (equatable-safe)
    private var coordinateKey: String {
        "\(coordinate.latitude),\(coordinate.longitude)"
    }

    var body: some View {
        Map(position: $cameraPosition) {
            Marker(trackerName, coordinate: coordinate)
                .tint(.red)
        }
        // New iOS 17+ style onChange: no params, not deprecated
        .onChange(of: coordinateKey) {
            withAnimation {
                cameraPosition = .region(
                    MKCoordinateRegion(
                        center: coordinate,
                        span: MKCoordinateSpan(latitudeDelta: 0.012, longitudeDelta: 0.012)
                    )
                )
            }
        }
        .cornerRadius(20)
        .shadow(color: .gray.opacity(0.25), radius: 6, x: 0, y: 4)
    }
}

#Preview {
    TrackersMapView(
        coordinate: CLLocationCoordinate2D(latitude: 55.751244, longitude: 37.618423),
        trackerName: "Demo Tracker"
    )
    .frame(height: 350)
    .padding()
}
