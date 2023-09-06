//
//  Activity.swift
//  SEL4C-APP
//
//  Created by Raúl Vélez on 04/09/23.
//

import Foundation


struct Activity: Identifiable {
    var id: String = UUID().uuidString
    var title: String
    var notes: String? = nil
    var isComplete: Bool = false
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
            isComplete: true),
        Activity(
            title: "Actividad 2",
            notes: "Investigación",
            isComplete: true),
        Activity(
            title: "Actividad 3",
            notes: "Ideación",
            isComplete: false),
        Activity(
            title: "Actividad 4",
            notes: "Socialización",
            isComplete: false),
        Activity(
            title: "Actividad Final",
            isComplete: false),
        
    ]
}
#endif
