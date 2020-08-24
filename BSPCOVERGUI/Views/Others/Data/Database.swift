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
}
