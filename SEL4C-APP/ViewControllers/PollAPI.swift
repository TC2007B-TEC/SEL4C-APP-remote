//
//  activityDoneAPI.swift
//  SEL4C-APP
//
//  Created by Raúl Vélez on 11/10/23.
//

import Foundation

class PollAPI {
    static let shared = PollAPI() // Singleton pattern for shared instance
    
    func sendTestJSON(_ email: String, _ testNum : String) {
        
        let data = [
            "test_type": testNum,
            "usuario": email
        ] as [String: Any]
        
        let jsonData = try! JSONSerialization.data(withJSONObject: data, options: .prettyPrinted)
        
        sendJSONData(jsonData, to: "http://20.127.122.6:8000/newtest/") { result in
            switch result {
            case .success:
                print("JSON para nuevo test enviado con éxito")
            case .failure(let error):
                print("Error al enviar JSON para nuevo test: \(error)")
            }
        }
    }

    func sendQuestionJSON(_ email: String, _ testNum : String, idpregunta: Int, respuesta: Int) {
        
        let data = [
            "idpregunta": idpregunta,
            "usuario": email,
            "test_type": testNum,
            "resp": respuesta

        ] as [String: Any]
        
        let jsonData = try! JSONSerialization.data(withJSONObject: data, options: .prettyPrinted)
        
        sendJSONData(jsonData, to: "http://20.127.122.6:8000/newpregunta/") { result in
            switch result {
            case .success:
                print("JSON para nueva pregunta enviado con éxito")
            case .failure(let error):
                print("Error al enviar JSON para nueva pregunta: \(error)")
            }
        }
    }

    func sendJSONData(_ jsonData: Data, to urlString: String, completion: @escaping (Result<Void, Error>) -> Void) {
        var request = URLRequest(url: URL(string: urlString)!)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody = jsonData
        
        URLSession.shared.dataTask(with: request) { (data, response, error) in
            if let error = error {
                completion(.failure(error))
                return
            }
            
            if let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 {
                completion(.success(()))
            } else {
                completion(.failure(UserResponsesError.itemNotFound))
            }
        }.resume()
    }
}
