//
//  XPBarView.swift
//  Swifty-Companion
//
//  Created by Joao Nascimento on 23.8.2023.
//

import SwiftUI

struct XPBarView: View {
    var xpPercentage: Double
    
    var body: some View {
        VStack(alignment: .leading) {
            Text("Lvl \(Int(xpPercentage))% - Foragers")
                .font(.headline)
            
            ProgressBar(value: xpPercentage, maxValue: 100)
                .progressViewStyle(LinearProgressViewStyle(tint: .blue))
        }
        .padding()
    }
}

struct XPBarView_Previews: PreviewProvider {
    static var previews: some View {
        XPBarView(xpPercentage: 75)
    }
}
