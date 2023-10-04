//
//  Activity.swift
//  SEL4C-APP
//
//  Created by Raúl Vélez on 04/09/23.
//

import Foundation
import UIKit

struct Activity: Identifiable {
    var id: String = UUID().uuidString
    var title: String
    var notes: String? = nil
    var subActivities: [Activity]
    var isComplete: Bool = false
    var image: UIImage?
    
}

extension [Activity] {
    func indexOfActivity(withId id: Activity.ID) -> Self.Index {
        guard let index = firstIndex(where: { $0.id == id }) else {
            fatalError()
        }
        return index
    }
}

#if DEBUG
extension Activity {
    static var sampleData = [
        Activity(
            title: "Actividad 1",
            notes: "Identificación",
            subActivities: [
                            Activity(title: "Actividad 1.1", notes: "Lluvia de ideas", subActivities: [], isComplete: false),
                            Activity(title: "Subactividad 1.2", notes: "Entrevista", subActivities: [], isComplete: false),
                            Activity(title: "Subactividad 1.3", notes: "Recorrido", subActivities: [], isComplete: false)
                        ],
            isComplete: true), 
            //image: UIImage.self(named:"instrucciones1")),
        Activity(
            title: "Actividad 2",
            notes: "Investigación",
            subActivities: [
                            Activity(title: "Actividad 2.1", notes: "ODS y ambiente", subActivities: [], isComplete: false),
                            Activity(title: "Subactividad 2.2", notes: "Retos y Desafíos", subActivities: [], isComplete: false),
                            Activity(title: "Subactividad 2.3", notes: "Árbol", subActivities: [], isComplete: false)
                        ],
            isComplete: true),
        Activity(
            title: "Actividad 3",
            notes: "Ideación",
            subActivities: [
                            Activity(title: "Actividad 3.1", notes: "Posibles soluciones", subActivities: [], isComplete: false),
                            Activity(title: "Subactividad 3.2", notes: "Reflexión", subActivities: [], isComplete: false),
                        ],
            isComplete: false),
        Activity(
            title: "Actividad 4",
            notes: "Socialización",
            subActivities: [],
            isComplete: false),
        Activity(
            title: "Actividad Final",
            subActivities: [],
            isComplete: false),
        
    ]
    
}


#endif
