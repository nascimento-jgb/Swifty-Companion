//
//  ProfileScrollView.swift
//  Swifty-Companion
//
//  Created by Joao Nascimento on 23.8.2023.
//

import SwiftUI

struct ProfileScrollView: View {
    @ObservedObject var apiUser: APIClient
    
    var body: some View {
        ScrollView{
            Text("HEY")
            Text("HEY")
            Text("HEY")
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .mask(RoundedRectangle(cornerRadius: 20, style: .continuous))
        .background(.regularMaterial)
        .padding(5)
    }
}

struct ProfileScrollView_Previews: PreviewProvider {
    static var previews: some View {
        let apiClient = APIClient(authenticationManager: AuthenticationManager())
        return ProfileScrollView(apiUser: apiClient)
            .environmentObject(AuthenticationManager())
    }
}
