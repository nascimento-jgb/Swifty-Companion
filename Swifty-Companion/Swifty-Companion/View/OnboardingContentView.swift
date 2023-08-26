//
//  OnboardContentView.swift
//  Swifty-Companion
//
//  Created by Joao Nascimento on 26.8.2023.
//

import SwiftUI

struct OnboardingContentView: View {
    @Binding var searchBarText: String
    var fetchData: () async -> Void
    
    var body: some View {
        ZStack {
            // Background animation
            
            VStack(alignment: .center, spacing: 24) {
                // Composed image/color with background
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
                    .onChange(of: searchBarText) { newValue in
                        searchBarText = newValue.lowercased()
                    }
                
                Button {
                    Task.init(priority: .userInitiated) {
                        await fetchData()
                    }
                } label: {
                    Text("Test API Request")
                        .padding(20)
                        .frame(maxWidth: .infinity)
                        .background(.gray)
                        .foregroundColor(.white)
                        .shadow(color: .gray, radius: 20, x: 0, y: 10)
                }
                .disabled(searchBarText.isEmpty)
                
                Spacer()
            }
        }
    }
}

struct OnboardingContentView_Previews: PreviewProvider {
    @State static var searchText: String = ""
    
    static func fetchData() async {
        // Implement your test data fetching logic here
    }
    
    static var previews: some View {
        OnboardingContentView(searchBarText: $searchText, fetchData: fetchData)
    }
}
