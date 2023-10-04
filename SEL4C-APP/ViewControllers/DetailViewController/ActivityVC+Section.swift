//
//  ActivityVC+Section.swift
//  SEL4C-APP
//
//  Created by Raúl Vélez on 04/10/23.
//

import Foundation

extension ActivityVC {
    enum Section: Int, Hashable{
        case date
        case notes
        case title
        case view
        
        var name: String {
                    switch self {
                    case .view: return ""
                    case .title:
                        return NSLocalizedString("Title", comment: "Title section name")
                    case .date:
                        return NSLocalizedString("Date", comment: "Date section name")
                    case .notes:
                        return NSLocalizedString("Notes", comment: "Notes section name")
                    }
                }
    }
}
