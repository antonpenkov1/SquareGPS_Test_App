//
//  ApiService.swift
//  SquareGPS Test App
//
//  Created by Антон Пеньков on 01.05.2026.
//

import Foundation

final class ApiService {
    static let shared = ApiService()
    init() {}
    
    private var sessionHash: String? {
        get { UserDefaults.standard.string(forKey: Constants.sessionKeychainKey) }
        set { UserDefaults.standard.setValue(newValue, forKey: Constants.sessionKeychainKey) }
    }
    
    private let urlSession: URLSession = .shared
    
    func authIfNeeded() async throws -> String {
        if let hash = sessionHash, !hash.isEmpty {
            return hash
        }
        
        var request = URLRequest(url: URL(string: Constants.baseURL + "user/auth")!)
        request.httpMethod = "POST"
        let body = [
            "login": Constants.demoLogin,
            "password": Constants.demoPassword
        ]
        request.httpBody = try JSONSerialization.data(withJSONObject: body)
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        NetworkLogger.log(request: request)
        let (data, response) = try await urlSession.data(for: request)
        NetworkLogger.log(response: response as? HTTPURLResponse, data: data, error: nil)
        let authResponse = try JSONDecoder().decode(AuthResponseDTO.self, from: data)
        if let hash = authResponse.hash {
            self.sessionHash = hash
            return hash
        } else {
            throw NSError(domain: "ApiService", code: -1, userInfo: [NSLocalizedDescriptionKey: "Auth failed"])
        }
    }
    
    func fetchTrackers() async throws -> [Tracker] {
        let hash = try await authIfNeeded()
        var request = URLRequest(url: URL(string: Constants.baseURL + "tracker/list")!)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        let bodyDict = ["hash": hash]
        request.httpBody = try JSONSerialization.data(withJSONObject: bodyDict)
        NetworkLogger.log(request: request)
        let (data, response) = try await urlSession.data(for: request)
        NetworkLogger.log(response: response as? HTTPURLResponse, data: data, error: nil)
        
        let trackersResponse = try JSONDecoder().decode(TrackerResponseDTO.self, from: data)
        return trackersResponse.list.map(TrackerMapper.map(dto:))
    }
    
    func fetchLastGpsPoint(trackerId: Int) async throws -> (lat: Double, lng: Double, heading: Double?) {
        let hash = try await authIfNeeded()
        var request = URLRequest(url: URL(string: Constants.baseURL + "tracker/get_last_gps_point")!)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        let body: [String: Any] = ["hash": hash, "tracker_id": trackerId]
        request.httpBody = try JSONSerialization.data(withJSONObject: body)
        NetworkLogger.log(request: request)
        let (data, response) = try await urlSession.data(for: request)
        NetworkLogger.log(response: response as? HTTPURLResponse, data: data, error: nil)
        
        let decoded = try JSONDecoder().decode(TrackerLastGpsPointResponseDTO.self, from: data)
        return (lat: decoded.value.lat, lng: decoded.value.lng, heading: decoded.value.heading)
    }
    
    func fetchCurrentStateCoords(trackerId: Int) async throws -> (lat: Double, lng: Double, heading: Double?) {
        let hash = try await authIfNeeded()
        var request = URLRequest(url: URL(string: Constants.baseURL + "tracker/get_state")!)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        let body: [String: Any] = ["hash": hash, "tracker_id": trackerId]
        request.httpBody = try JSONSerialization.data(withJSONObject: body)
        NetworkLogger.log(request: request)
        let (data, response) = try await urlSession.data(for: request)
        NetworkLogger.log(response: response as? HTTPURLResponse, data: data, error: nil)
        
        let decoded = try JSONDecoder().decode(TrackerStateResponseDTO.self, from: data)
        
        guard let location = decoded.state.gps?.location else {
            throw NSError(domain: "NoLocation", code: 404, userInfo: [NSLocalizedDescriptionKey: "No coordinates"])
        }
        let heading = decoded.state.gps?.heading
        return (lat: location.lat, lng: location.lng, heading: heading)
    }
}
