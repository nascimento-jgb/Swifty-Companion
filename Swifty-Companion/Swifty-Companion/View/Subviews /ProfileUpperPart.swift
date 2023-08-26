//
//  ProfileUpperPart.swift
//  Swifty-Companion
//
//  Created by Joao Nascimento on 23.8.2023.
//

import SwiftUI

struct ProfileUpperPart: View {
    @ObservedObject var apiUser: APIClient
    
    var body: some View {
        
        VStack{
            Circle()
                .foregroundColor(Color(hex: apiUser.coalition!.color))
                .frame(width: 160, height: 160)
            
            if (apiUser.data!.image.link != nil) {
               AsyncImage(
                   url: URL(string: apiUser.data!.image.link!),
                   content: { image in
                       image.resizable()
                           .resizable()
                           .scaledToFit()
                           .frame(width: 140, height: 140)
                           .clipShape(Circle())
                           .overlay(Circle().stroke(Color.white, lineWidth: 2))
                           .offset(y: -157)
                   },
                   placeholder: {
                       ProgressView()
                   }
               )
           }
            else {
                Image("Incognito")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 100, height: 100)
                    .clipShape(Circle())
                    .overlay(Circle().stroke(Color.white, lineWidth: 2))
                    .offset(y: -115)
            }
//            Button("Print Cursus Users") {
//                    printUser(apiUser: apiUser)
//                  }
            
            Text(apiUser.data!.login + " - " + apiUser.coalition!.name)
                .padding(.top,  -80)
            
            Text(apiUser.data!.location ?? "N/A")
                .padding(.top, -38)
            
            XPBarView(apiUser: apiUser, xpPercentage: apiUser.data?.cursus_users[1].level ?? 0.0)
        }
    }
    
    func printUser(apiUser: APIClient) {
      if let user = apiUser.data {
        print("Login: \(user.login)")
        print("Image: \(user.image)")
        if let location = user.location {
          print("Location: \(location)")
        }
        
        print("Cursus Users:")
        for (index, cursusUser) in user.cursus_users.enumerated() {
          print(" Grade: \(cursusUser.grade ?? "None"), Level: \(cursusUser.level)")
          for skill in cursusUser.skills {
            print("  Skill: \(skill.name), Level: \(skill.level)")
          }
          
          if cursusUser.grade == "Learner" && cursusUser.level == 5.8 {
            print("  Index in Array: \(index)")
          }
        }
        
        print("Achievements:")
        for achievement in user.achievements {
          print(" ID: \(achievement.id), Name: \(achievement.name), Visible: \(achievement.visible)")
        }
        
        print("Projects Users:")
        for projectUser in user.projects_users {
          print(" ID: \(projectUser.id), Final Mark: \(projectUser.final_mark ?? 0), Status: \(projectUser.status)")
          print("  Project: \(projectUser.project.name), Cursus IDs: \(projectUser.cursus_ids)")
          if let markedAt = projectUser.marked_at {
            print("  Marked At: \(markedAt)")
          }
        }
      }
    }


}

struct ProfileUpperPart_Previews: PreviewProvider {
    static var previews: some View {
        let apiClient = APIClient(authenticationManager: AuthenticationManager())
        return ProfileUpperPart(apiUser: apiClient)
            .environmentObject(AuthenticationManager())
    }
}
