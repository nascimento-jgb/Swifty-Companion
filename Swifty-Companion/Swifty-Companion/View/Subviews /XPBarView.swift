//
//  XPBarView.swift
//  Swifty-Companion
//
//  Created by Joao Nascimento on 23.8.2023.
//

import SwiftUI

struct XPBarView: View {
//    @ObservedObject var apiUser: APIClient
    var xpPercentage: Double
    
    var body: some View {
        VStack(alignment: .leading) {
            Text("Lvl \(String(format: "%.2f", xpPercentage))")
                .font(.headline)
            
//            ProgressBar(apiUser: apiUser, value: xpPercentage, maxValue: 25)
//                .progressViewStyle(LinearProgressViewStyle(tint: .blue))
            
            ProgressBar(value: xpPercentage, maxValue: 25)
                .progressViewStyle(LinearProgressViewStyle(tint: .blue))
        }
        .padding()
    }
}

struct XPBarView_Previews: PreviewProvider {
    static var previews: some View {
//        let apiClient = APIClient(authenticationManager: AuthenticationManager())
//        XPBarView(apiUser: apiClient, xpPercentage: 75)
        XPBarView(xpPercentage: 15)
    }
}
