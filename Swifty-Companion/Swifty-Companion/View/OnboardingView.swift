//
//  ContentView.swift
//  Swifty-Companion
//
//  Created by Joao Nascimento on 19.8.2023.
//

import SwiftUI

struct OnboardingView: View {
    @StateObject var authManager = AuthenticationManager()
    @State private var searchBarText: String  = ""
    
    var body: some View {
        ZStack{
            
            //42 BACKGROUND ANIMATION HERE
            
            VStack(alignment: .center, spacing: 24){
                
                //COMPOSED IMAGE/COLOR WITH BACKGROUND
                Spacer()
                
                Text("SPACE HOLDER 42 LOGO")
                TextField("Type here the student login", text: $searchBarText)
                    .mask(RoundedRectangle(cornerRadius: 20, style: .continuous))
                    .shadow(radius: 5, x: 0, y: 3)
                    .padding(20)
                    .foregroundColor(.white)
                    .background(Color.gray)
                    .overlay(RoundedRectangle(cornerRadius: 0, style: .continuous)
                        .stroke(Color.black.opacity(0.7), lineWidth: 2))

                
                Button{
                    //Instert the action here
                    authManager.autheticate()
                } label: {
                    Label("Search", systemImage: "arrow.right")
                        .padding(20)
                        .frame(maxWidth: .infinity)
                        .background(.gray)
                        .foregroundColor(.white)
                        .shadow(color: .gray, radius: 20, x:0, y: 10)
                }
                
                Spacer()
            }
            .padding(50)
            .background(.regularMaterial)
            .mask(RoundedRectangle(cornerRadius: 20, style: .continuous))
            .shadow(radius: 5, x: 0, y: 3)
            .shadow(radius: 30, x: 0, y: 30)
            .padding(20)
        }
    }
}

struct OnboardingView_Previews: PreviewProvider {
    static var previews: some View {
        OnboardingView()
    }
}
