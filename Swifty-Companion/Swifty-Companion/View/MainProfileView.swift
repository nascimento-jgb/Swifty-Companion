//
//  ProfileView.swift
//  Swifty-Companion
//
//  Created by Joao Nascimento on 21.8.2023.
//

import SwiftUI

struct MainProfileView: View {
    @Binding var apiUser: APIClient?

    var body: some View {
        ZStack{
            
            //Insert here coalition type background
            
            VStack(alignment: .center, spacing: 14){
                
                ProfileUpperPart()
            
                ProfileButtonsView()
                
                ProfileScrollView()
                
            }
            .padding()
        }
    }
}



struct MainProfileView_Previews: PreviewProvider {
    static var previews: some View {
        return OnboardingView()
            .environmentObject(AuthenticationManager())
    }
}
