//
//  ProfileUpperPart.swift
//  Swifty-Companion
//
//  Created by Joao Nascimento on 23.8.2023.
//

import SwiftUI

struct ProfileUpperPart: View {
    var body: some View {
        
        VStack{
            Circle()
                .foregroundColor(.blue)
                .frame(width: 120, height: 120)
            
            Image(systemName: "person.fill")
                .resizable()
                .scaledToFit()
                .frame(width: 90, height: 90)
                .clipShape(Circle())
                .overlay(Circle().stroke(Color.white, lineWidth: 2))
                .offset(y: -120)
            
            Text("Name of user")
                .padding(.top,  -80)
            
            XPBarView(xpPercentage: 75.0)
                .padding(.top, -60)
        }
    }
}

struct ProfileUpperPart_Previews: PreviewProvider {
    static var previews: some View {
        ProfileUpperPart()
    }
}
