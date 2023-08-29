//
//  SingleAchievement.swift
//  Swifty-Companion
//
//  Created by Joao Nascimento on 29.8.2023.
//

import SwiftUI

struct SingleAchievement: View {
        var name: String
        
        var body: some View {
            
            VStack{
                HStack(alignment: .center, spacing: 10){
                  
                    Image(systemName: name)
                        .resizable()
                        .scaledToFit()
                        .foregroundColor(.red)
                        .frame(width: 60, height: 60)
                    
                    
                    Text("\(name)")
                        .frame(maxWidth: .infinity, alignment: .trailing)
                        .padding()
                        .foregroundColor(.black)
                }
                .padding(.horizontal, 40)
                .padding(6)
            }
        }
    }

struct SingleAchievement_Previews: PreviewProvider {
    static var previews: some View {
        SingleAchievement(name: "circle")
    }
}
