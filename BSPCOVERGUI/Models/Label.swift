//
//  Label.swift
//  BSPCOVERGUI
//
//  Created by TheRedLee on 8/25/20.
//

import Foundation

struct Label: Hashable, Codable, Identifiable {
    var id: Int
    var value: Int
    var name: String { return "label - \(value)"}
}
