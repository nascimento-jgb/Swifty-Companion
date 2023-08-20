//
//  ClientAPI.swift
//  Swifty-Companion
//
//  Created by Joao Nascimento on 20.8.2023.
//

import Foundation

class APIClient {
    private let baseURL: String = "https://api.intra.42.fr" // Replace with the API base URL
    private let authenticationManager: AuthenticationManager
    
    init(authenticationManager: AuthenticationManager) {
        self.authenticationManager = authenticationManager
    }

    func makeAuthenticatedRequest<T: Codable>(endpoint: String, completion: @escaping (Result<T, Error>) -> Void) {
        guard let accessToken = authenticationManager.oauthToken else {
            let error = NSError(domain: "YourAppErrorDomain", code: 401, userInfo: [NSLocalizedDescriptionKey: "Access token is missing"])
            completion(.failure(error))
            return
        }

        let urlString = baseURL + endpoint
        guard let url = URL(string: urlString) else {
            let error = NSError(domain: "YourAppErrorDomain", code: 400, userInfo: [NSLocalizedDescriptionKey: "Invalid URL"])
            completion(.failure(error))
            return
        }

        var request = URLRequest(url: url)
        request.setValue("Bearer \(accessToken)", forHTTPHeaderField: "Authorization")

        URLSession.shared.dataTask(with: request) { data, _, error in
            if let error = error {
                completion(.failure(error))
                return
            }

            if let data = data {
                do {
                    let decodedObject = try JSONDecoder().decode(T.self, from: data)
                    completion(.success(decodedObject))
                } catch {
                    completion(.failure(error))
                }
            }
        }.resume()
    }
}
