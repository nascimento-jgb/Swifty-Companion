//
//  ProfileView.swift
//  Swifty-Companion
//
//  Created by Joao Nascimento on 21.8.2023.
//

import SwiftUI

struct MainProfileView: View {
    @ObservedObject var apiUser: APIClient
    @Binding var isDataAvailable: Bool
    @Binding var searchBarText: String
    @State private var selectedButton = "Projects"
    
    var body: some View {
        NavigationStack{
            ZStack{
                Image(apiUser.coalitionImage(apiUser: apiUser))
                    .resizable()
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .ignoresSafeArea()

                VStack(alignment: .center){
                    ProfileUpperPart(apiUser: apiUser)

                    ProfileButtonsView(apiUser: apiUser, selectedButton: $selectedButton)

                    ProfileScrollView(apiUser: apiUser, selectedButton: $selectedButton)
                }
                .padding()
            }
            .frame(maxWidth: .infinity)
            .onDisappear{
                isDataAvailable = false
                searchBarText = ""
            }
        }
    }
}

struct MainProfileView_Previews: PreviewProvider {
    static var previews: some View {
        let apiClient = APIClient(authenticationManager: AuthenticationManager())
        return MainProfileView(apiUser: apiClient, isDataAvailable: .constant(true), searchBarText: .constant("test"))
            .environmentObject(AuthenticationManager())
    }
}
