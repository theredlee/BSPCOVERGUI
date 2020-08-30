//
//  ContentView.swift
//  BSPCOVERGUI
//
//  Created by TheRedLee on 8/24/20.
//

import SwiftUI
import Charts

struct ContentView: View {
    @State private var selectedTimeseries: Timeseries?
    @State var selectedTimeseriesLabel: Label?
    @State var selectedShapelet: Shapelet?
    @State var selectedShapeletLabel: Label?
    @State var str: String = "Content View Started"
    @State var timeseriesArr: [Timeseries]?
    @State var entryArr: [[BarChartDataEntry]]?
    let numOfTimeserie: Int = 10
    
    var body: some View {
//        let timeseriesArr = DatabaseManager.shared.getTopKTimeseries(defaultTopK: numOfTimeserie, shapelet: selectedShapelet ?? Database.shared.defaultShapelet)
        
        NavigationView {
            NavigationPrimary(str: $str, selectedTimeseries: $selectedTimeseries, selectedTimeseriesLabel: $selectedTimeseriesLabel, selectedShapelet: $selectedShapelet, selectedShapeletLabel: $selectedShapeletLabel)
            
            //            TabOverall(selectedTimeseries: $selectedTimeseries, selectedShapelet: $selectedShapelet)
            Carousel(selectedTimeseries: $selectedTimeseries, selectedTimeseriesLabel: $selectedTimeseriesLabel, selectedShapelet: $selectedShapelet, selectedShapeletLabel: $selectedShapeletLabel, timeseriesArr: $timeseriesArr, entryArr: $entryArr, str: $str)
        }
        .navigationTitle("BSPCOVERGUI")
        .frame(minWidth: 700, minHeight: 300)
        .onChange(of: selectedShapelet, perform: { value in
            if !(Database.shared.shapeletIsInit && Database.shared.timeseriesIsInit) {
                timeseriesArr = [Database.shared.defaultTimeseries]
                return
            }
            let count: Int = Database.shared.shapeletCount
            var numOfTimeserie: Int = 0
            
            if count >= self.numOfTimeserie {
                numOfTimeserie = self.numOfTimeserie
            } else {
                numOfTimeserie = count
            }
            timeseriesArr = DatabaseManager.shared.getTopKTimeseries(defaultTopK: numOfTimeserie, shapelet: selectedShapelet ?? Database.shared.defaultShapelet)
            //            let a = String(selectedShapelet?.id ?? -1)
            //            let b = "\n\(String(describing: timeseriesArr?.count)) - \(String(describing: timeseriesArr?[0].id))"
            //            let b = timeseriesArr?.count
            //            str = a + b
            entryArr = getHistogramEntry().0
        })
    }
    
    private func getHistogramEntry() -> ([[BarChartDataEntry]], [Int]) {
        let allTimeseries = Database.shared.allTimeseries
        let allTimeseriesLabels = Database.shared.allTimeseriesLabels
        let distanceMap = Database.shared.distanceMap
        var alldistances = [[DistanceDetail]]()
        var entriesArr = [[BarChartDataEntry]]()
        
        // Divide distanceDetail according to labels
        distanceMap.forEach { distance in
            if distance.shapeletId == selectedShapelet?.id {
                let distanceDetails = distance.distanceDetails
                //
                allTimeseriesLabels.forEach { label in
                    var distanceArrWithLabel = [DistanceDetail]()
                    //
                    distanceDetails.forEach { distanceDetail in
                        let timeseriesLabel = DatabaseManager.shared.binarySearch(in: allTimeseries, for: distanceDetail.timeseriesId)?.label
                        if label.value == timeseriesLabel?.value {
                            distanceArrWithLabel.append(distanceDetail)
                        }
                    }
                    // Sort the array
                    let sortedDistanceWithLabelArr: [DistanceDetail] = distanceArrWithLabel.sorted(by: ({ $0.distance < $1.distance }))
                    //
                    alldistances.append(sortedDistanceWithLabelArr)
                }
                return
            }
        }
        
        // Establish the bins
        var allInterval = [Int]()
        var isGet = false
        alldistances.forEach { distanceDetailsWithLabel in
            let min:Double = distanceDetailsWithLabel.first?.distance ?? 1
            let max:Double = distanceDetailsWithLabel.last?.distance ?? 0
            let numOfBins:Int = 25
            let interval: Double = max-min
            let intervalUnit: Double = interval/Double(numOfBins)
            var entries = [BarChartDataEntry]()
            
            var count: [Int] = {
                var count = [Int]()
                for _ in 0..<numOfBins {
                    count.append(0)
                }
                return count
            }()
            
            var base: Int = 1
            distanceDetailsWithLabel.forEach { distanceDetail in
                //
                for index in 1..<numOfBins+1 {
                    let binVal = Double(index)/Double(25)*interval
                    let distance: Double = distanceDetail.distance
                    
                    if distance < binVal+min {
                        count[index-1] += 1
                        break
                    }
                    
                    base = {
                        var base: Int = 1
                        if intervalUnit <= 0 {
                            return 1
                        }
                        while floor(intervalUnit*Double(base))<1 {
                            base = base * 10
                        }
                        return base/10
                    }()
                    
                    // Handle the last element which is not included into the count[lastIndex]
                    if index == (numOfBins+1)-1 {
                        count[index-1] += 1
                    }
                }
            }
            
            
            
            //
            for index in 0..<count.count {
                let val = count[index]
                let binVal = Double(index)*intervalUnit
                let allCount = Double(distanceDetailsWithLabel.count)
                let sequence = Double(val)/allCount
                entries.append(BarChartDataEntry(x: Double(binVal*Double(base)), y: sequence))
            }
            entriesArr.append(entries)
            
            if !isGet {
                allInterval = count
                isGet = true
            }
        }
        return (entriesArr, allInterval)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
