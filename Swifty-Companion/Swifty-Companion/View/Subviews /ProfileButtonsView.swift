//
//  ProfileButtonsView.swift
//  Swifty-Companion
//
//  Created by Joao Nascimento on 23.8.2023.
//

import SwiftUI

struct ProfileButtonsView: View {
    @ObservedObject var apiUser: APIClient
    @Binding var selectedButton: String
    
    var body: some View {
        HStack{
            Button{
                selectedButton = "Projects"
            } label: {
                Text("Projects")
                    .font(AppFont.header)
                    .padding(4)
                    .frame(maxWidth: .infinity)
                    .frame(height: 40)
                    .background(Color(hex: apiUser.coalition!.color))
                    .foregroundColor(.white)
                    .cornerRadius(20, corners: [.topRight, .bottomLeft, .bottomRight])
                    .cornerRadius(8, corners: [.topLeft])
                    .shadow(color: Color(hex: apiUser.coalition!.color), radius: 20, x: 0, y: 10)
            }
            
            Spacer()
            
            Button{
                selectedButton = "Achievements"
            } label: {
                Text("Achievements")
                    .font(AppFont.header)
                    .padding(4)
                    .frame(maxWidth: .infinity)
                    .frame(height: 40)
                    .background(Color(hex: apiUser.coalition!.color))
                    .foregroundColor(.white)
                    .cornerRadius(20, corners: [.topRight, .bottomLeft, .bottomRight])
                    .cornerRadius(8, corners: [.topLeft])
                    .shadow(color: Color(hex: apiUser.coalition!.color), radius: 20, x: 0, y: 10)
            }
            
            Spacer()
            
            Button{
                selectedButton = "Skills"
            } label: {
                Text("Skills")
                    .font(AppFont.header)
                    .padding(4)
                    .frame(maxWidth: .infinity)
                    .frame(height: 40)
                    .background(Color(hex: apiUser.coalition!.color))
                    .foregroundColor(.white)
                    .cornerRadius(20, corners: [.topRight, .bottomLeft, .bottomRight])
                    .cornerRadius(8, corners: [.topLeft])
                    .shadow(color: Color(hex: apiUser.coalition!.color), radius: 20, x: 0, y: 10)
            }
        }
        .padding()
    }
}



struct ProfileButtonsView_Previews: PreviewProvider {
    static var previews: some View {
        let apiClient = APIClient(authenticationManager: AuthenticationManager())
        return ProfileButtonsView(apiUser: apiClient, selectedButton: .constant("Projects"))
            .environmentObject(AuthenticationManager())
    }
}
