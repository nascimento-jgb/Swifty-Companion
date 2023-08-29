//
//  Project.swift
//  Swifty-Companion
//
//  Created by Joao Nascimento on 29.8.2023.
//

import SwiftUI

struct Project: View {
    var body: some View {
        
        VStack{
            HStack(alignment: .center, spacing: 10){
                VStack(alignment: .leading){
                    Text("CPP Module 00")
                        .foregroundColor(.green)
                    Text("1 year ago")
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                
                Text("100")
                    .padding(.top, -12)
                    .foregroundColor(.green)
            }
            .padding(.horizontal, 40)
            .padding(6)
        }
    }
}

struct Project_Previews: PreviewProvider {
    static var previews: some View {
        Project()
    }
}
