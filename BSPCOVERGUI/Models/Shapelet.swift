//
//  Shapelet.swift
//  BSPCOVERGUI
//
//  Created by TheRedLee on 8/24/20.
//

import Foundation

struct Shapelet: Hashable, Codable, Identifiable {
    var id: Int
    var name: String
    var values: [Double]
    var label: Label
}
