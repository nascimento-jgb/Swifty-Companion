//
//  ContentView.swift
//  Swifty-Companion
//
//  Created by Joao Nascimento on 19.8.2023.
//

import SwiftUI

struct OnboardingView: View {
    @StateObject var authManager = AuthenticationManager()
    @State private var searchBarText: String = ""
    @State private var isDataAvailable: Bool = false
    @StateObject private var apiClient: APIClient = APIClient(authenticationManager: AuthenticationManager())
    
    var body: some View {
        NavigationStack {
            if isDataAvailable {
                MainProfileView(apiUser: apiClient)
            } else {
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




//PRINTING TESTS


//                    Task{
//                        do {
//                                await apiUser?.fetchData(login: searchBarText)
//                                if let user = apiUser?.data {
//                                    print("User Login: \(user.login)")
//                                    print("User Location: \(user.location ?? "N/A")")
//                                    print("User Image: \(user.image)")
//
//                                    print("Cursus Users:")
//                                    for cursus in user.cursus_users {
//                                        print("- Grade: \(cursus.grade ?? "N/A")")
//                                        print("- Level: \(cursus.level)")
//                                        print("  Skills:")
//                                        for skill in cursus.skills {
//                                            print("  - ID: \(skill.id), Name: \(skill.name), Level: \(skill.level)")
//                                        }
//                                    }
//
//                                    print("Achievements:")
//                                    for achievement in user.achievements {
//                                        print("- ID: \(achievement.id), Name: \(achievement.name), Visible: \(achievement.visible)")
//                                    }
//
//                                    print("Projects Users:")
//                                    for projectUser in user.projects_users {
//                                        print("- ID: \(projectUser.id)")
//                                        print("- Final Mark: \(projectUser.final_mark ?? -1)")
//                                        print("- Status: \(projectUser.status)")
//                                        print("- Project: \(projectUser.project.name)")
//                                        print("- Cursus IDs: \(projectUser.cursus_ids)")
//                                        print("- Marked At: \(projectUser.marked_at ?? "N/A")")
//                                    }
//                                } else {
//                                    print("User data is nil")
//                                }
//                            if let newuser = apiUser?.coalition {
//                                print("Coalition id: \(newuser.id)")
//                                print("Coalition name: \(newuser.name)")
//                                print("Coalition image_url: \(newuser.image_url)")
//                                print("Coalition color: \(newuser.color)")
//
//                            }   else {
//                                print("User data is nil")
//                            }
//                            }
//                        }
