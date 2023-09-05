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
    @State private var showErrorAlert: Bool = false
    @State private var showMainProfileView: Bool = false
    @State private var authenticationFlag: Bool = false
    
    var body: some View {
     
        NavigationStack {
            if !isDataAvailable {
                ZStack{
                    Image("intra-background")
                        .resizable()
                        .blur(radius: 2)
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                        .ignoresSafeArea()
                    
                    OnboardingContentView(searchBarText: $searchBarText, localFetchData: localFetchData)
                        .padding(50)
                        .background(.regularMaterial)
                        .mask(RoundedRectangle(cornerRadius: 20, style: .continuous))
                        .shadow(radius: 5, x: 0, y: 3)
                        .shadow(radius: 30, x: 0, y: 30)
                        .padding(20)
                        .task {
                            await authenticateAndFetchData()
                        }
                    //navigationDestination needed to be substituted by navigationLink
                    NavigationLink("", destination: MainProfileView(apiUser: apiClient, isDataAvailable: $isDataAvailable, searchBarText: $searchBarText), isActive: $isDataAvailable)
                }
                .alert(isPresented: $showErrorAlert) {
                    Alert(
                        title: Text("Error"),
                        message: Text("The user doesn't exist."),
                        dismissButton: .default(Text("OK")) )
                    }
                }
            }
            .accentColor(.white)
    }
    
    private func localFetchData() async {
        do {
            try await apiClient.fetchData(login: searchBarText)
            isDataAvailable = true
        } catch {
            print("Error fetching data: \(error)")
            showErrorAlert = true
        }
    }
        
    private func authenticateAndFetchData() async {
        if (authenticationFlag == false){
            authManager.authenticate()
            apiClient.authenticationManager = authManager
            authenticationFlag = true
        }
        
        if !searchBarText.isEmpty {
            await localFetchData()
        }
    }
    
}

struct OnboardingView_Previews: PreviewProvider {
    static var previews: some View {
        OnboardingView()
    }
}
