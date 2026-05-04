//
//  NetworkLogger.swift
//  SquareGPS Test App
//
//  Created by Антон Пеньков on 01.05.2026.
//

import Foundation

final class NetworkLogger {
    static func log(request: URLRequest) {
        print("[HTTP Request]")
        if let method = request.httpMethod, let url = request.url {
            print("(method) (url.absoluteString)")
        }
        if let headers = request.allHTTPHeaderFields {
            print("Headers: (headers)")
        }
        if let body = request.httpBody, !body.isEmpty,
           let str = String(data: body, encoding: .utf8) {
            print("Body: (str)")
        }
    }
    
    static func log(response: HTTPURLResponse?, data: Data?, error: Error?) {
        print("[HTTP Response]")
        if let response = response {
            print("Status: \(response.statusCode) URL: \(response.url?.absoluteString ?? "")")
        }
        if let data = data, !data.isEmpty,
           let str = String(data: data, encoding: .utf8) {
            print("Data: \(str)")
        }
        if let error = error {
            print("Error: \(error)")
        }
    }
}
