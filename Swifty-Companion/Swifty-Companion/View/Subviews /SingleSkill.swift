//
//  SingleSkill.swift
//  Swifty-Companion
//
//  Created by Joao Nascimento on 29.8.2023.
//

import SwiftUI

struct SingleSkill: View {
    
    var name: String
    var level: Double
    
    var body: some View {
        VStack{
            HStack(alignment: .center, spacing: 10){
                Text(name)
                    
                Spacer()
                
                Text("\(level)")
                    .foregroundColor(.green)
            }
            .padding(.horizontal, 40)
            .padding(6)
        }
    }
}


struct SingleSkill_Previews: PreviewProvider {
    static var previews: some View {
        SingleSkill(name: "skill name", level: 10.00)
    }
}
