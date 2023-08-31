//
//  ContentView.swift
//  Swifty-Companion
//
//  Created by Joao Nascimento on 19.8.2023.
//

import SwiftUI

struct OnboardingView: View {
    @StateObject var authManager = AuthenticationManager()
    @StateObject private var apiClient: APIClient = APIClient(authenticationManager: AuthenticationManager())
    @State private var searchBarText: String = ""
    @State private var isDataAvailable: Bool = false
    
    var body: some View {
            
            NavigationStack {
                if isDataAvailable {
                    MainProfileView(apiUser: apiClient)
                } else {
                    
                    ZStack{
                        Image("intra-background")
                            .resizable()
                            .blur(radius: 2)
                            .frame(maxWidth: .infinity, maxHeight: .infinity)
                            .ignoresSafeArea()
                        
                        OnboardingContentView(searchBarText: $searchBarText, fetchData: fetchData)
                            .padding(50)
                            .background(.regularMaterial)
                            .mask(RoundedRectangle(cornerRadius: 20, style: .continuous))
                            .shadow(radius: 5, x: 0, y: 3)
                            .shadow(radius: 30, x: 0, y: 30)
                            .padding(20)
                            .task {
                                await authenticateAndFetchData()
                            }
                    }
                }
            }
        }
    
    private func fetchData() async {
        do {
                try await apiClient.fetchData(login: searchBarText)
                isDataAvailable = true
            } catch {
                print("Error fetching data: \(error)")
            }
    }
    
    private func authenticateAndFetchData() async {
        authManager.authenticate()
        apiClient.authenticationManager = authManager
        await fetchData()
    }
}

struct OnboardingView_Previews: PreviewProvider {
    static var previews: some View {
        OnboardingView()
    }
}
