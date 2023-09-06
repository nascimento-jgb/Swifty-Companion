//
//  ClientAPI.swift
//  Swifty-Companion
//
//  Created by Joao Nascimento on 20.8.2023.
//
import Foundation

enum APIClientError: Error {
    case userNotFound
    case apiError(Error)
    case missingAccessToken
    case invalidURL
}

// APIClient is a class that handles API requests and manages user data.
final class APIClient : ObservableObject {
    @Published var data: User? // User data fetched from the API.
    @Published var coalition: Coalition? // User's coalition data fetched from the API.
    
    
    private let baseURL: String = "https://api.intra.42.fr/v2/users/"
    private let urlSession = URLSession.shared
    public var authenticationManager: AuthenticationManager
    
    
    // Initializes the APIClient with an AuthenticationManager.
    init(authenticationManager: AuthenticationManager) {
        self.authenticationManager = authenticationManager
    }
    
    // Fetches user info from the API.
    func getUserInfo(login: String) async throws -> User? {
        // Check if access token is available.
        guard let accessToken = authenticationManager.oauthToken else {
            throw APIClientError.missingAccessToken
        }

        let urlString = baseURL + login.lowercased()
        guard let requestUrl = URL(string: urlString) else {
            throw APIClientError.invalidURL
        }

        var request = URLRequest(url: requestUrl)
        request.setValue("Bearer \(accessToken)", forHTTPHeaderField: "Authorization")

        do {
            let (data, _) = try await urlSession.data(for: request)
            let decoder = JSONDecoder()
            let currentUser = try decoder.decode(User.self, from :data)
            return currentUser
        } catch {
            throw error
        }
    }
    
    // Fetches user's coalition info from the API.
    func getUserCoalition(login: String) async throws -> Coalition? {
        // Check if access token is available.
        guard let accessToken = authenticationManager.oauthToken else {
            throw APIClientError.missingAccessToken
        }
        
        let urlString = baseURL + login.lowercased() + "/coalitions"
        guard let requestUrl = URL(string: urlString) else {
            throw APIClientError.invalidURL
        }
        
        var request = URLRequest(url: requestUrl)
        request.setValue("Bearer \(accessToken)", forHTTPHeaderField: "Authorization")
        
        let (data, _) = try await urlSession.data(for: request)
        let currentUserCoalition = try JSONDecoder().decode([Coalition].self, from: data)
        let currentUserCoalitionSize = currentUserCoalition.count - 1
        
        guard !currentUserCoalition.isEmpty else {
            return nil
        }
        
        for i in 0...currentUserCoalitionSize {
            if (currentUserCoalition[i].id >= 271 && currentUserCoalition[i].id <= 273) {
                return currentUserCoalition[i]
            }
        }
        return nil
    }
    
    // Returns the image name based on the coalition name.
    func coalitionImage(apiUser: APIClient) -> String {
        if let coalitionName = apiUser.coalition?.name {
            if coalitionName == "The Foragers" {
                return "foragers_background"
            } else if coalitionName == "The Guards" {
                return "guards_background"
            } else {
                return "builders_background"
            }
        } else {
            // Handle the case when apiUser.coalition is nil
            return "intra-background"
        }
    }
    
    // Fetches user data and coalition data from the API.
    @MainActor
        func fetchData (login: String) async throws {
            do {
                data = try await getUserInfo(login: login)
                coalition = try await getUserCoalition(login: login)
            } catch APIClientError.userNotFound {
                throw APIClientError.userNotFound
            } catch {
                throw APIClientError.apiError(error)
            }
    }
}


