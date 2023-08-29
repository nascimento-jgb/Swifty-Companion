//
//  Project.swift
//  Swifty-Companion
//
//  Created by Joao Nascimento on 29.8.2023.
//

import SwiftUI

struct SingleProject: View {
    
    var name: String
    var status:  String
    var score: Int
    
    var body: some View {
        
        VStack{
            HStack(alignment: .center, spacing: 10){
                VStack(alignment: .leading){
                    Text(name)
                        .foregroundColor(.green)
                    Text(status)
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                
                Text("\(score)")
                    .padding(.top, -12)
                    .foregroundColor(.green)
            }
            .padding(.horizontal, 40)
            .padding(6)
        }
    }
}

struct SingleProject_Previews: PreviewProvider {
    static var previews: some View {
        SingleProject(name: "CPP Module 00", status: "1 year ago", score: 100)
    }
}
