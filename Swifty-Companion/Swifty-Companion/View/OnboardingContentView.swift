//
//  OnboardContentView.swift
//  Swifty-Companion
//
//  Created by Joao Nascimento on 26.8.2023.
//

import SwiftUI

struct OnboardingContentView: View {
    @Binding var searchBarText: String
    var localFetchData: () async -> Void
    
    var body: some View {
        ZStack {
            
            VStack(alignment: .center, spacing: 24) {
                
                Spacer()
                
                Image("42logo")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 100, height: 100)
                    .offset(x: -10)
                
                TextField("Student login", text: $searchBarText)
                    .font(AppFont.title2)
                    .multilineTextAlignment(.center)
                    .shadow(radius: 5, x: 0, y: 3)
                    .padding(20)
                    .foregroundColor(.gray)
                    .background(.white).opacity(0.9)
                    .cornerRadius(20, corners: [.topRight, .bottomLeft, .bottomRight])
                    .cornerRadius(8, corners: [.topLeft])
                    .onChange(of: searchBarText) { newValue in
                        searchBarText = newValue.lowercased()
                    }
                
                Button{
                    Task{
                        await localFetchData()
                    }
                } label: {
                    Text("Info Request")
                        .font(AppFont.title2)
                        .padding(20)
                        .frame(maxWidth: .infinity)
                        .background(.black).opacity(0.9)
                        .foregroundColor(.white)
                        .cornerRadius(20, corners: [.topRight, .bottomLeft, .bottomRight])
                        .cornerRadius(8, corners: [.topLeft])
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
    
    static func localFetchData() async {
        // test data fetching logic here
    }
    
    static var previews: some View {
        OnboardingContentView(searchBarText: $searchText, localFetchData: localFetchData)
    }
}
