//
//  Database.swift
//  BSPCOVERGUI
//
//  Created by TheRedLee on 8/24/20.
//

import Foundation

final class Database {
    
    /// Shared instance of class
    public static let values: [Timeseries] = DatabaseManager.shared.initData()
    
    public static let defaultValue: Timeseries = values[0]
    
    public static let allLabels: [Int] = {
        var allLabels = Set<Int>()
        
        for timeseries in Database.values {
            allLabels.insert(timeseries.label.value)
        }

        return Array(allLabels).sorted()
    }()
}
