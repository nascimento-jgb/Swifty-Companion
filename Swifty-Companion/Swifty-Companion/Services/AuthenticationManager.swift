//
//  TokenAPI.swift
//  Swifty-Companion
//
//  Created by Joao Nascimento on 20.8.2023.
//

import Foundation
import OAuthSwift

class AuthenticationManager : ObservableObject {
    @Published var oauthToken: String? = nil
    private lazy var oauthSwift: OAuth2Swift? = initializeOAuthSwift()
    
    private func initializeOAuthSwift() -> OAuth2Swift? {
            if let apiConfig = loadAPIConfig() {
                return OAuth2Swift(
                    consumerKey: apiConfig.apiUID,
                    consumerSecret: apiConfig.apiSecret,
                    authorizeUrl: "https://api.intra.42.fr/oauth/authorize",
                    responseType: "code"
                )
            } else {
                return nil
            }
        }
    
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
    
    func generateState(withLength length: Int) ->String{
        let characters = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"
        let state = (0..<length).map{_ in characters.randomElement()!}
        return String(state)
    }
    
    @MainActor
        func autheticate() {
            guard let oauthSwift = oauthSwift else {
                return
            }
            
            // Redirect user to authorization URL
            let _ = oauthSwift.authorize(
                withCallbackURL: URL(string: "mycoolapp://oauth-callback")!,
                scope: "public",
                state: generateState(withLength: 10),
                completionHandler: { result in
                    switch result {
                    case .success(let (credential, _, _)):
                        // Handle successful authorization
                        self.oauthToken = credential.oauthToken
                        print("OAuth token: \(credential.oauthToken)")
                    case .failure(let error):
                        // Handle error
                        print("Authentication error: \(error.localizedDescription)")
                    }
                }
            )
        }
    
}
