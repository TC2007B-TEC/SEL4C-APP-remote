//
//  Data.swift
//  SEL4C-APP
//
//  Created by Raúl Vélez on 08/10/23.
//

//import Foundation
//
//public extension Data {
//
//    mutating func append(
//        _ string: String,
//        encoding: String.Encoding = .utf8
//    ) {
//        guard let data = string.data(using: encoding) else {
//            return
//        }
//        append(data)
//    }
//}

import Foundation

extension Data {
    
    mutating func append(_ string: String) {
        if let data = string.data(using: .utf8) {
            self.append(data)
        }
    }
}
