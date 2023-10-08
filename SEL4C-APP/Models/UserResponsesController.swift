//
//  UserResponsesController.swift
//  SEL4C-APP
//
//  Created by Román Mauricio Elias Valencia on 05/10/23.
//

import Foundation

enum UserResponsesError: Error, LocalizedError{
    case itemNotFound
}
class UserResponsesController {
    let baseString = "http://20.127.122.6:8000/newpregunta/"
    
    func insertUserResponses(jsonData: Data) async throws -> Void {
        let insertURL = URL(string: baseString)!
        var request = URLRequest(url: insertURL)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody = jsonData
        
        let (data, response) = try await URLSession.shared.data(for: request)
        guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
            throw UserResponsesError.itemNotFound
        }
    }
}
