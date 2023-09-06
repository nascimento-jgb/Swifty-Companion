//
//  TokenAPI.swift
//  Swifty-Companion
//
//  Created by Joao Nascimento on 20.8.2023.
//

import Foundation
import OAuthSwift

final class AuthenticationManager : ObservableObject {
    @Published var oauthToken: String? = nil
    @Published var refreshToken: String? = nil
    @Published var tokenExpirationDate: Date? = nil

    
    // Initialize OAuth2Swift instance lazily
    private lazy var oauthSwift: OAuth2Swift? = initializeOAuthSwift()
    
    // Initialize OAuth2Swift instance with API credentials
    private func initializeOAuthSwift() -> OAuth2Swift? {
        if let apiConfig = loadAPIConfig() {
            let oauthswift = OAuth2Swift(
                consumerKey: apiConfig.apiUID,
                consumerSecret: apiConfig.apiSecret,
                authorizeUrl: "https://api.intra.42.fr/oauth/authorize",
                accessTokenUrl: "https://api.intra.42.fr/oauth/token",
                responseType: "code"
            )
            return oauthswift
        } else {
            return nil
        }
    }
    
    // Load API credentials from a plist file
    private func loadAPIConfig() -> (apiSecret: String, apiUID: String)? {
        if let plistURL = Bundle.main.url(forResource: "42API-Info", withExtension: "plist"),
           let plistData = try? Data(contentsOf: plistURL) {
            
            if let plistDictionary = try? PropertyListSerialization.propertyList(from: plistData, format: nil) as? [String: Any] {
                
                if let apiSecret = plistDictionary["API_SECRET"] as? String,
                   let apiUID = plistDictionary["API_UID"] as? String {
                    return (apiSecret, apiUID)
                }
            }
        }
        return nil
    }
    
    // Generate a random state string
    func generateState(withLength length: Int) -> String {
        let characters = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"
        let state = (0..<length).map{_ in characters.randomElement()!}
        return String(state)
    }
    
    // Refresh the access token using the refresh token
    func refreshAccessToken() {
        guard let oauthSwift = oauthSwift,
              let refreshToken = refreshToken else {
            return
        }

        oauthSwift.renewAccessToken(withRefreshToken: refreshToken) { result in
               switch result {
               case .success(let (tokenSuccess, _, _)):
                   self.oauthToken = tokenSuccess.oauthToken
                   self.refreshToken = tokenSuccess.oauthRefreshToken
                   self.tokenExpirationDate = tokenSuccess.oauthTokenExpiresAt ?? Date()
                   print("Refreshed OAuth token: \(tokenSuccess.oauthToken)")
               case .failure(let error):
                   print("Failed to refresh access token: \(error.localizedDescription)")
               }
           }
    }
    
    // Check if the access token has expired and refresh it if needed
    func checkTokenExpiration() {
        guard let tokenExpirationDate = tokenExpirationDate else {
            return
        }

        if Date() > tokenExpirationDate {
            refreshAccessToken()
        }
    }
    
    // Authenticate the user using OAuth2Swift
    @MainActor
    func authenticate() {
        guard let oauthSwift = oauthSwift else {
            return
        }
        
        let _ = oauthSwift.authorize(
            withCallbackURL: URL(string: "mycoolapp://oauth-callback")!,
            scope: "public",
            state: generateState(withLength: 10),
            completionHandler: { result in
                switch result {
                case .success(let (credential, _, _)):
                    self.oauthToken = credential.oauthToken
                    self.refreshToken = credential.oauthRefreshToken
                    self.tokenExpirationDate = credential.oauthTokenExpiresAt ?? Date()
                    print("OAuth token: \(credential.oauthToken)")
                case .failure(let error):
                    print("Authentication error: \(error.localizedDescription)")
                }
            }
        )
    }
}
