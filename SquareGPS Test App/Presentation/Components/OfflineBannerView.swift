//
//  OfflineBannerView.swift
//  SquareGPS Test App
//
//  Created by Антон Пеньков on 01.05.2026.
//

import SwiftUI

struct OfflineBannerView: View {
    let isOffline: Bool
    let errorText: String?

    var body: some View {
        if let errorText = errorText, !errorText.isEmpty {
            Text(errorText)
                .font(.system(size: 15, weight: .medium))
                .foregroundColor(.white)
                .padding()
                .background(Color.red)
                .cornerRadius(10)
                .padding(.horizontal)
                .padding(.top, 4)
                .transition(.move(edge: .top))
        } else if isOffline {
            HStack {
                Image(systemName: "wifi.slash")
                    .foregroundColor(.white)
                Text("Offline mode: showing cached data")
                    .foregroundColor(.white)
                    .font(.system(size: 15, weight: .medium))
            }
            .padding()
            .background(Color.orange)
            .cornerRadius(10)
            .padding(.horizontal)
            .padding(.top, 4)
            .transition(.move(edge: .top))
        } else {
            EmptyView()
        }
    }
}

#Preview {
    VStack(spacing: 20) {
        OfflineBannerView(isOffline: false, errorText: nil)
        OfflineBannerView(isOffline: true, errorText: nil)
        OfflineBannerView(isOffline: false, errorText: "Unable to update!")
    }
    .padding()
}
