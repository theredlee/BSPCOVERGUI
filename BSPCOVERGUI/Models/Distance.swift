//
//  DistanceMap.swift
//  BSPCOVERGUI
//
//  Created by TheRedLee on 8/30/20.
//

import Foundation

struct Distance: Hashable, Codable {
    var shapeletId: Int
    var distanceDetails: [DistanceDetail]
}

struct DistanceDetail: Hashable, Codable {
    var timeseriesId: Int
    var distance: Double
    var startPosition: Int
}
