//
//  Database.swift
//  BSPCOVERGUI
//
//  Created by TheRedLee on 8/24/20.
//

import Foundation

final class Database: ObservableObject {
    
    /// Shared instance of class
    public static let shared = Database()
    
    // Timeseries property
    public var allTimeseries: [Timeseries]
    
    public var defaultTimeseries: Timeseries
    
    public var timeseriesCount: Int
    
    public var allTimeseriesLabels: [Label]
    
    public var defaultTimeseriesLabel: Label
    
    public var timeseriesIsInit: Bool = false
    
    // Shapelet property
    public var allShapelets: [Shapelet]
    
    public var defaultShapelet: Shapelet
    
    public var shapeletCount: Int
    
    public var allShapeletLabels: [Label]
    
    public var defaultShapeletLabel: Label
    
    public var shapeletIsInit: Bool = false
    
    // Distances match between shapelets and timeseries
    public var distMapArr: [[[String: Double]]]
    
    //
    init() {
        // Timeseries
        allTimeseriesLabels = [Label(id: -1, value: -1)]
        allTimeseries = [Timeseries(id: -1, values: [0], label: allTimeseriesLabels[0])]
        defaultTimeseries = allTimeseries[0]
        defaultTimeseriesLabel = Label(id: -1, value: -1)
        timeseriesCount = -1
        
        // Shapelet
        allShapeletLabels = [Label(id: -1, value: -1)]
        allShapelets = [Shapelet(id: -1, values: [0], label: allShapeletLabels[0])]
        defaultShapelet = allShapelets[0]
        defaultShapeletLabel = Label(id: -1, value: -1)
        shapeletCount = -1
        
        // Distance Map
        distMapArr = [[["unInitializedVal": -1]]]
    }
}

extension Database {
    // Timeseries func
    public func timeseriesInsert(myAllTimeseries: [Timeseries]) -> String {
        guard myAllTimeseries.count > 0 else {
            print("Failed to fetch timeseries.")
            return "Failed to fetch timeseries."
        }
        
        // Check activation
        if !timeseriesIsInit {
            allTimeseries = myAllTimeseries
            timeseriesIsInit = true
        }else{
            allTimeseries += myAllTimeseries
        }
        
        timeseriesPropertySynchronize()
        
        print("Successfully initialize timeseries data into database")
        return "Successfully initialize timeseries data into database \n\(allTimeseries.count)"
    }
    
    private func timeseriesPropertySynchronize() {
        defaultTimeseries = allTimeseries[0]
        timeseriesCount = allTimeseries.count
        allTimeseriesLabels = {
            var allVal = Set<Int>()
            for timeseries in allTimeseries {
                allVal.insert(timeseries.label.value)
            }
            let valSorted = Array(allVal).sorted()
            var allLabels = [Label]()
            
            for index in 0..<valSorted.count {
                allLabels.append(Label(id: index, value: valSorted[index]))
            }
            
            return allLabels
        }()
        defaultTimeseriesLabel = allTimeseriesLabels[0]
    }
}

extension Database {
    // Shapelet func
    public func shapeletInsert(myAllShapelets: [Shapelet]) -> String {
        guard myAllShapelets.count > 0 else {
            print("Failed to fetch shapelet.")
            return "Failed to fetch shapelet."
        }
        
        // Check activation
        if !shapeletIsInit {
            allShapelets = myAllShapelets
            shapeletIsInit = true
        }else{
            allShapelets += myAllShapelets
        }
        
        shapeletPropertySynchronize()
        
        print("Successfully initialize shapelet data into database")
        return "Successfully initialize shapelet data into database \n\(allShapelets.count)"
    }
    
    private func shapeletPropertySynchronize() {
        defaultShapelet = allShapelets[0]
        shapeletCount = allShapelets.count
        allShapeletLabels = {
            var allVal = Set<Int>()
            for shapelet in allShapelets {
                allVal.insert(shapelet.label.value)
            }
            let valSorted = Array(allVal).sorted()
            var allLabels = [Label]()
            
            for index in 0..<valSorted.count {
                allLabels.append(Label(id: index, value: valSorted[index]))
            }
            
            return allLabels
        }()
        defaultShapeletLabel = allShapeletLabels[0]
    }
    
    public func initDistMap(distMapArr: [[[String: Double]]]) {
        self.distMapArr = distMapArr
    }
}
