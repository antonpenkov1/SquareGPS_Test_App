//
//  ActivityIndicatorView.swift
//  SquareGPS Test App
//
//  Created by Антон Пеньков on 01.05.2026.
//

import SwiftUI

struct ActivityIndicatorView: View {
    var body: some View {
        VStack {
            Spacer()
            ProgressView()
                .progressViewStyle(CircularProgressViewStyle(tint: Color.accentColor))
                .scaleEffect(1.7)
                .padding()
            Spacer()
        }
    }
}

#Preview {
    ActivityIndicatorView()
        .frame(height: 120)
        .background(Color(.systemBackground))
}
