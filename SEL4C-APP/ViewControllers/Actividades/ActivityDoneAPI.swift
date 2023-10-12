//
//  activityDoneAPI.swift
//  SEL4C-APP
//
//  Created by Raúl Vélez on 11/10/23.
//

import Foundation

class ActivityDoneAPI {
    static let shared = ActivityDoneAPI() // Singleton pattern for shared instance
    
    let group = DispatchGroup()
    
    func getAPI(email: String, name: String, completion: @escaping (Bool) -> Void) {
        // Definir la URL del endpoint de la API
        let url = URL(string: "http://20.127.122.6:8000/verifact/")!

        // Crear un objeto URLRequest con el método POST
        var request = URLRequest(url: url)
        request.httpMethod = "POST"

        // Crear el objeto JSON que se enviará como cuerpo de la solicitud
        let json = [
            "name": name,
            "email": email
        ]

        // Codificar el objeto JSON a datos binarios
        let jsonData = try? JSONSerialization.data(withJSONObject: json)
        

        // Asignar los datos binarios al cuerpo de la solicitud
        request.httpBody = jsonData

        // Asignar el tipo de contenido adecuado a los encabezados de la solicitud
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        group.enter()
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            // ...
            do {
                if let json = try? JSONSerialization.jsonObject(with: data!) {
                    print("Respuesta JSON: \(json)")
                    completion(true)
                } else {
                    print("Respuesta de texto: \(String(data: data!, encoding: .utf8) ?? "")")
                    completion(false)
                }
            } catch {print("Error ")}
        }
        task.resume()
    }
}

