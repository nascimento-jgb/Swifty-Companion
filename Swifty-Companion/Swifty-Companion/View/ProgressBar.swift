//
//  ProgressBar.swift
//  Swifty-Companion
//
//  Created by Joao Nascimento on 22.8.2023.
//

import SwiftUI

struct ProgressBar: View {
    
    var value: Double
    var maxValue: Double
    
    var body: some View {
        GeometryReader { geometry in
            ZStack(alignment: .leading) {
                Rectangle()
                    .foregroundColor(.gray)
                    .frame(width: geometry.size.width, height: 20)
                
                Rectangle()
                    .foregroundColor(.blue)
                    .frame(width: geometry.size.width * CGFloat(value / maxValue), height: 20)
            }
        }
    }
}

struct ProgressBar_Previews: PreviewProvider {
    static var previews: some View {
        ProgressBar(value: 75, maxValue: 100)
    }
}
