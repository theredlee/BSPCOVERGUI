//
//  Timeseries.swift
//  BSPCOVERGUI
//
//  Created by TheRedLee on 8/24/20.
//

import Foundation

struct Timeseries: Hashable, Codable, Identifiable {
    var id: Int
    var name: String
    var values: [Double]
    var label: Label
}
