//
//  ActivityVC+Row.swift
//  SEL4C-APP
//
//  Created by Raúl Vélez on 04/09/23.
//

import UIKit


extension ActivityVC {
    enum Row: Hashable {
        case date
        case notes
        case time
        case title


        var imageName: String? {
            switch self {
            case .date: return "instrucciones1"
            case .notes: return "square.and.pencil"
            case .time: return "clock"
            default: return nil
            }
        }


        var image: UIImage? {
            guard let imageName = imageName else { return nil }
            let configuration = UIImage.SymbolConfiguration(textStyle: .headline)
            return UIImage(systemName: imageName, withConfiguration: configuration)
        }


        var textStyle: UIFont.TextStyle {
            switch self {
            case .title: return .headline
            default: return .subheadline
            }
        }
    }
}

extension ActivityVC2 {
    enum Row: Hashable {
        case date
        case notes
        case time
        case title


        var imageName: String? {
            switch self {
            case .date: return "instrucciones1"
            case .notes: return "square.and.pencil"
            case .time: return "clock"
            default: return nil
            }
        }


        var image: UIImage? {
            guard let imageName = imageName else { return nil }
            let configuration = UIImage.SymbolConfiguration(textStyle: .headline)
            return UIImage(systemName: imageName, withConfiguration: configuration)
        }


        var textStyle: UIFont.TextStyle {
            switch self {
            case .title: return .headline
            default: return .subheadline
            }
        }
    }
}
