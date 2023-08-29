//
//  ProfileView.swift
//  Swifty-Companion
//
//  Created by Joao Nascimento on 21.8.2023.
//

import SwiftUI

struct MainProfileView: View {
    @ObservedObject var apiUser: APIClient
    @State private var selectedButton = "Projects"
    
    var body: some View {
        ZStack{
            
            //Insert here coalition type background
            
            VStack(alignment: .center){
//                ProfileUpperPart(apiUser: apiUser)
                ProfileUpperPart()
                
                ProfileButtonsView(apiUser: apiUser, selectedButton: $selectedButton)
                
                ProfileScrollView(apiUser: apiUser, selectedButton: $selectedButton)
            }
            .padding()
        }
        .frame(maxWidth: .infinity)
    }
}



struct MainProfileView_Previews: PreviewProvider {
    static var previews: some View {
        let apiClient = APIClient(authenticationManager: AuthenticationManager())
        return MainProfileView(apiUser: apiClient)
            .environmentObject(AuthenticationManager())
    }
}
