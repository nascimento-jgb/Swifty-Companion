//
//  ProfileButtonsView.swift
//  Swifty-Companion
//
//  Created by Joao Nascimento on 23.8.2023.
//

import SwiftUI

struct ProfileButtonsView: View {
    @ObservedObject var apiUser: APIClient
    
    var body: some View {
        HStack{
            Button{
                
            } label: {
                Text("First button")
                    .mask(RoundedRectangle(cornerRadius: 20, style: .continuous))
                    .background(.gray)
                    .foregroundColor(.white)
            }
            
            Button{
                
            } label: {
                Text("Second button")
                    .mask(RoundedRectangle(cornerRadius: 20, style: .continuous))
                    .background(.gray)
                    .foregroundColor(.white)
            }
            
            Button{
                
            } label: {
                Text("Third button")
                    .mask(RoundedRectangle(cornerRadius: 20, style: .continuous))
                    .background(.gray)
                    .foregroundColor(.white)
            }
        }
        .padding()
    }
}

struct ProfileButtonsView_Previews: PreviewProvider {
    static var previews: some View {
        let apiClient = APIClient(authenticationManager: AuthenticationManager())
        return ProfileButtonsView(apiUser: apiClient)
            .environmentObject(AuthenticationManager())
    }
}
