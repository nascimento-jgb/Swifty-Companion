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
            generateButton(param: "Projects")
            Spacer()
            generateButton(param: "Achievements")
            Spacer()
            generateButton(param: "Skills")
        }
        .padding()
    }
    
    private func generateButton(param: String) -> Button<some View> {
        return   Button{
            selectedButton = param
        } label: {
            Text(param)
                .font(AppFont.body3)
                .padding(4)
                .frame(maxWidth: .infinity)
                .frame(height: 40)
                .background(Color(hex: apiUser.coalition?.color ?? "#ffffff") )
                .foregroundColor(.white)
                .cornerRadius(20, corners: [.topRight, .bottomLeft, .bottomRight])
                .cornerRadius(8, corners: [.topLeft])
                .shadow(color: Color(hex: apiUser.coalition?.color ?? "#ffffff"), radius: 20, x: 0, y: 10)
        }
    }
}

struct ProfileButtonsView_Previews: PreviewProvider {
    static var previews: some View {
        let apiClient = APIClient(authenticationManager: AuthenticationManager())
        return ProfileButtonsView(apiUser: apiClient, selectedButton: .constant("Projects"))
            .environmentObject(AuthenticationManager())
    }
}
