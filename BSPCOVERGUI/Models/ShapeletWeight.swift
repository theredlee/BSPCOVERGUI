//
//  ShapeletWeight.swift
//  BSPCOVERGUI
//
//  Created by TheRedLee on 8/29/20.
//

import Foundation

struct ShapeletWeight: Hashable, Codable, Identifiable {
    var id: Int
    var name: String { return "shapeletWeight - \(id)" }
    var value: Double
    var label: Label
}
