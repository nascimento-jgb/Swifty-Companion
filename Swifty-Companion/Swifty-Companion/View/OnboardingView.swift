//
//  ContentView.swift
//  Swifty-Companion
//
//  Created by Joao Nascimento on 19.8.2023.
//

import SwiftUI

struct OnboardingView: View {
    @StateObject var authManager = AuthenticationManager()
    @State var searchBarText: String = ""
    
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
                    .onChange(of: searchBarText) { newValue in
                            searchBarText = newValue.lowercased()
                        }
                    
                Button{
                    //Instert the action here
                        authManager.authenticate()
                    
                } label: {
                    Label("Authenticate", systemImage: "")
                        .padding(20)
                        .frame(maxWidth: .infinity)
                        .background(.gray)
                        .foregroundColor(.white)
                        .shadow(color: .gray, radius: 20, x:0, y: 10)
                }
                
                Button {
                    
                    let apiClient = APIClient(authenticationManager: authManager)
                    Task{
                        do {
                                await apiClient.fetchData(login: searchBarText)
                                if let user = apiClient.data {
                                    print("User Login: \(user.login)")
                                    print("User Location: \(user.location ?? "N/A")")
                                    print("User Image: \(user.image)")
                                    
                                    print("Cursus Users:")
                                    for cursus in user.cursus_users {
                                        print("- Grade: \(cursus.grade ?? "N/A")")
                                        print("- Level: \(cursus.level)")
                                        print("  Skills:")
                                        for skill in cursus.skills {
                                            print("  - ID: \(skill.id), Name: \(skill.name), Level: \(skill.level)")
                                        }
                                    }
                                    
                                    print("Achievements:")
                                    for achievement in user.achievements {
                                        print("- ID: \(achievement.id), Name: \(achievement.name), Visible: \(achievement.visible)")
                                    }
                                    
                                    print("Projects Users:")
                                    for projectUser in user.projects_users {
                                        print("- ID: \(projectUser.id)")
                                        print("- Final Mark: \(projectUser.final_mark ?? -1)")
                                        print("- Status: \(projectUser.status)")
                                        print("- Project: \(projectUser.project.name)")
                                        print("- Cursus IDs: \(projectUser.cursus_ids)")
                                        print("- Marked At: \(projectUser.marked_at ?? "N/A")")
                                    }
                                } else {
                                    print("User data is nil")
                                }
                            if let newuser = apiClient.coalition {
                                print("Coalition id: \(newuser.id)")
                                print("Coalition name: \(newuser.name)")
                                print("Coalition image_url: \(newuser.image_url)")
                                print("Coalition color: \(newuser.color)")
                                
                            }   else {
                                print("User data is nil")
                            }
                            }
                        }
                } label: {
                    Text("Test API Request")
                        .padding(20)
                        .frame(maxWidth: .infinity)
                        .background(.gray)
                        .foregroundColor(.white)
                        .shadow(color: .gray, radius: 20, x: 0, y: 10)
                }
                .disabled(authManager.oauthToken == nil)
                
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
