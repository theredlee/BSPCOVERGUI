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
    
    // Shapelet weight property
    public var allShapeletWeights: [ShapeletWeight]
    
    public var defaultShapeletWeights: ShapeletWeight
    
    public var shapeletWeightsCount: Int
    
    public var allShapeletWeightLabels: [Label]
    
    public var defaultShapeletWeightLabel: Label
    
    public var shapeletWeightIsInit: Bool = false
    
    
    // Distances match between shapelets and timeseries
    public var distanceMap: [Distance]
    
    //
    init() {
        // Timeseries
        defaultTimeseriesLabel = Label(id: -1, value: -1)
        defaultTimeseries = Timeseries(id: -1, values: [0], label: defaultTimeseriesLabel)
        allTimeseriesLabels = [defaultTimeseriesLabel]
        allTimeseries = [defaultTimeseries]
        timeseriesCount = allTimeseries.count
        
        // Shapelet
        defaultShapeletLabel = Label(id: -1, value: -1)
        defaultShapelet = Shapelet(id: -1, values: [0], label: defaultShapeletLabel)
        allShapeletLabels = [defaultShapeletLabel]
        allShapelets = [defaultShapelet]
        shapeletCount = allShapelets.count
        
        // Shapelet Weight
        defaultShapeletWeightLabel = Label(id: -1, value: -1)
        defaultShapeletWeights = ShapeletWeight(id: -1, value: 1.0, label: defaultShapeletWeightLabel)
        allShapeletWeightLabels = [defaultShapeletWeightLabel]
        allShapeletWeights = [defaultShapeletWeights]
        shapeletWeightsCount = allShapeletWeights.count
        
        // Distance Map
        distanceMap = [Distance(shapeletId: defaultShapelet.id, distanceDetails: [DistanceDetail(timeseriesId: defaultTimeseries.id, distance: 0, startPosition: 0)])]
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
            return "\nDuplicated function call from shapeletInsert(myAllShapelets: ...)"
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
    
    public func initDistMap(distMapArr: [Distance]) {
        self.distanceMap = distMapArr
    }
}

extension Database {
    // Shapelet weight func
    public func shapeletWeightInsert(myAllShapeletWeights: [ShapeletWeight]) -> String {
        guard myAllShapeletWeights.count > 0 else {
            print("Failed to fetch shapelet.")
            return "Failed to fetch shapelet."
        }
        
        // Check activation
        if !shapeletWeightIsInit {
            allShapeletWeights = {
                // Sort all weights
                let allShapeletWeights = myAllShapeletWeights.sorted {
                    $0.value < $1.value
                }
                return allShapeletWeights
            }()
            shapeletWeightIsInit = true
        }else{
            return "Duplicated function call from shapeletWeightInsert(myAllShapeletWeights: ...)"
        }
        
        shapeletWeightPropertySynchronize()
        
        print("Successfully initialize shapelet data into database")
        return "Successfully initialize shapelet data into database \n\(allShapeletWeights.count)"
    }
    
    private func shapeletWeightPropertySynchronize() {
        defaultShapeletWeights = allShapeletWeights[0]
        shapeletWeightsCount = allShapeletWeights.count
        allShapeletWeightLabels = {
            var allVal = Set<Int>()
            for shapeletWeight in allShapeletWeights {
                allVal.insert(shapeletWeight.label.value)
            }
            let valSorted = Array(allVal).sorted()
            var allLabels = [Label]()
            
            for index in 0..<valSorted.count {
                allLabels.append(Label(id: index, value: valSorted[index]))
            }
            
            return allLabels
        }()
        defaultShapeletWeightLabel = allShapeletWeightLabels[0]
    }
}
