//
//  ProgressBar.swift
//  Swifty-Companion
//
//  Created by Joao Nascimento on 22.8.2023.
//

import SwiftUI

struct ProgressBar: View {
    @ObservedObject var apiUser: APIClient
    var value: Double
    var maxValue: Double
    
    var body: some View {
        GeometryReader { geometry in
            ZStack(alignment: .leading) {
                Rectangle()
                    .foregroundColor(.gray)
                    .frame(width: geometry.size.width, height: 20)
                
                Rectangle()
                    .foregroundColor(Color(hex: apiUser.coalition!.color))
                    .frame(width: geometry.size.width * CGFloat(value / maxValue), height: 20)
            }
        }
    }
}

struct ProgressBar_Previews: PreviewProvider {
    static var previews: some View {
        let apiClient = APIClient(authenticationManager: AuthenticationManager())
        ProgressBar(apiUser: apiClient, value: 75, maxValue: 100)
    }
}