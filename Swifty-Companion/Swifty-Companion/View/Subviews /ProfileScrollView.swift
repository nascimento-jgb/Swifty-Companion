//
//  ProfileScrollView.swift
//  Swifty-Companion
//
//  Created by Joao Nascimento on 23.8.2023.
//

import SwiftUI

struct ProfileScrollView: View {
    @ObservedObject var apiUser: APIClient
    @Binding var selectedButton: String
    
    var body: some View {
        ScrollView{
           if (selectedButton == "Projects") {
               ForEach(apiUser.data?.projects_users ?? [], id: \.id) { projectUser in
                   SingleProject(name: projectUser.project.name, status: projectUser.status, score: projectUser.final_mark ?? 0)
               }
           } else if (selectedButton == "Achievements") {
               ForEach(apiUser.data?.achievements ?? [], id: \.id) { achievements in
                   SingleAchievement(name: achievements.name)
               }
           }
//            else if (selectedButton == "Skills") {
//               ForEach(apiUser.data?.achievements ?? [], id: \.id) { cursus_user in
//                   ForEach(cursus_user.skills, id: \.id) { skills in
//                       SingleSkill(name: skills.name , level: skills.level)
//                   }
//               }
//           }
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
        return ProfileScrollView(apiUser: apiClient, selectedButton: .constant("Projects"))
            .environmentObject(AuthenticationManager())
    }
}
