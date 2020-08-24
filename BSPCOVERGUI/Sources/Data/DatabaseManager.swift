//
//  Database.swift
//  BSPCOVERGUI
//
//  Created by TheRedLee on 8/24/20.
//

import Foundation

final class DatabaseManager {
    
    /// Shared instance of class
    public static let shared = DatabaseManager()
    
    public func initData() -> [Timeseries] {
        var values = [Timeseries]()
        values.append(DatabaseManager.shared.addData(num: 0))
        values.append(DatabaseManager.shared.addData(num: 1))
        values.append(DatabaseManager.shared.addData(num: 2))
        return values
    }
    
    private func addData(num: Int) -> Timeseries {
        let values = addvalues(num: num)
        return Timeseries(id: num, name: "timeseries - \(num)", values: values)
    }
    
    private func addvalues(num: Int) -> [Double] {
        return Array(1..<10).map { x in return sin(Double(x*num) / 2.0 / 3.141 * 1.5) }
    }
}

extension DatabaseManager {
    public enum DatabaseError: Error {
        case failedToFetch
        
        public var localizedDescription: String {
            switch self {
            case .failedToFetch:
                return "This means blah failed"
            }
        }
    }
}
