//
//  ProfileView.swift
//  Swifty-Companion
//
//  Created by Joao Nascimento on 21.8.2023.
//

import SwiftUI

struct MainProfileView: View {
    @ObservedObject var apiUser: APIClient

    var body: some View {
        ZStack{
            
            //Insert here coalition type background
            
            VStack(alignment: .center, spacing: 14){
                
                ProfileUpperPart(apiUser: apiUser)
            
                ProfileButtonsView(apiUser: apiUser)
                
                ProfileScrollView(apiUser: apiUser)
                
            }
            .padding()
        }
    }
}



struct MainProfileView_Previews: PreviewProvider {
    static var previews: some View {
        let apiClient = APIClient(authenticationManager: AuthenticationManager())
        return MainProfileView(apiUser: apiClient)
            .environmentObject(AuthenticationManager())
    }
}
