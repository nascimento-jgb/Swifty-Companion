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
        
        ZStack{
            Circle()
                .foregroundColor(.white)
                .frame(width: 160, height: 160)
                .offset(y: -75)
            
            VStack{
                if (apiUser.data?.image.link != nil) {
                    AsyncImage(
                        url: URL(string: apiUser.data!.image.link!),
                        content: { image in
                            image.resizable()
                                .resizable()
                                .scaledToFit()
                                .frame(width: 140, height: 140)
                                .clipShape(Circle())
                                .overlay(Circle().stroke(Color(hex: apiUser.coalition?.color ?? "#ffffff"), lineWidth: 2))
                                .padding(.top, 5)
                        },
                        placeholder: {
                            Image(systemName: "circle.fill")
                                .resizable()
                                .scaledToFit()
                                .foregroundColor(.white)
                                .frame(width: 140, height: 140)
                                .clipShape(Circle())
                                .overlay(Circle().stroke(Color.white, lineWidth: 2))
                                .padding(.top, 5)
                        }
                    )
                }
                else {
                    Image("incognito")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 100, height: 100)
                        .clipShape(Circle())
                        .overlay(Circle().stroke(Color.white, lineWidth: 2))
                        .padding(.top, 15)
                }
                
                Text((apiUser.data?.login ?? "Not given") + " - " + (apiUser.coalition?.name ?? "Not given"))
                    .padding()
                    .foregroundColor(.white)
                    .font(AppFont.title)

                Text(apiUser.data?.location ?? "N/A")
                    .padding(.top, 1)
                    .foregroundColor(.white)
                    .font(AppFont.subtitle)
                
                XPBarView(apiUser: apiUser, xpPercentage: apiUser.data?.cursus_users[1].level ?? 0.0)
                    .padding(.top, -25)
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

