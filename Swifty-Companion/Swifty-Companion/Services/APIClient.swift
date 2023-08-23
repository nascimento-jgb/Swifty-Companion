//
//  ClientAPI.swift
//  Swifty-Companion
//
//  Created by Joao Nascimento on 20.8.2023.
//
import Foundation

class APIClient : ObservableObject {
    @Published var data: User?
    @Published var coalition: Coalition?
    @Published var isDataCollected: Bool = false
    @Published var isNotExisting: Bool = false
    
    private let baseURL: String = "https://api.intra.42.fr/v2/users/"
    private let authenticationManager: AuthenticationManager
    
    init(authenticationManager: AuthenticationManager) {
        self.authenticationManager = authenticationManager
    }

    func getUserInfo(login: String) async throws -> User? {
        guard let accessToken = authenticationManager.oauthToken else {
            let error = NSError(domain: "YourAppErrorDomain", code: 401, userInfo: [NSLocalizedDescriptionKey: "Access token is missing"])
            throw error
        }

        let urlString = baseURL + login.lowercased()
        guard let requestUrl = URL(string: urlString) else {
            print("Error: Url is empty")
            return nil
        }

        var request = URLRequest(url: requestUrl)
        request.setValue("Bearer \(accessToken)", forHTTPHeaderField: "Authorization")

        do {
            let (data, _) = try await URLSession.shared.data(for: request)
            let decoder = JSONDecoder()
            let currentUser = try decoder.decode(User.self, from :data)
            return currentUser
        } catch {
            throw error
        }
    }
    
    func getUserCoalition(login: String) async throws -> Coalition? {
        guard let accessToken = authenticationManager.oauthToken else {
            let error = NSError(domain: "YourAppErrorDomain", code: 401, userInfo: [NSLocalizedDescriptionKey: "Access token is missing"])
            throw error
        }
        
        let urlString = baseURL + login.lowercased() + "/coalitions"
        guard let requestUrl = URL(string: urlString) else {
            print("Error: Url is empty")
            return nil
        }

        var request = URLRequest(url: requestUrl)
        request.setValue("Bearer \(accessToken)", forHTTPHeaderField: "Authorization")
        
        let (data, _) = try await URLSession.shared.data(for: request)
        let decoder = JSONDecoder()
        let currentUserCoalition = try decoder.decode([Coalition].self, from: data)
        let currentUserCoalitionSize = currentUserCoalition.count - 1
        if (!currentUserCoalition.isEmpty) {
            for i in 0...currentUserCoalitionSize {
                if (currentUserCoalition[i].id >= 271 && currentUserCoalition[i].id <= 273) {
                    return currentUserCoalition[i]
                }
            }
        }
        return nil
    }
    
    @MainActor
        func fetchData (login: String) async {
            do {
                data = try await getUserInfo(login: login)
                coalition = try await getUserCoalition(login: login)
                isDataCollected = true
            } catch {
                isNotExisting = true
                print("Error: Couldn't get the info on this user")
            }
        }
}
