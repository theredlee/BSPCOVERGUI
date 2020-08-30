//
//  TabDetails.swift
//  BSPCOVERGUI
//
//  Created by TheRedLee on 8/24/20.
//

import SwiftUI
import Charts

struct TabDetails: View {
    @Binding var selectedTimeseries: Timeseries?
    @Binding var selectedShapelet: Shapelet?
    @Binding var timeseriesArr: [Timeseries]?
    //    @State var str: String = ""
    
    var body: some View {
        let allShapeletWeights = Database.shared.allShapeletWeights
        let entries: [BarChartDataEntry] = {
            var entries = [BarChartDataEntry]()
            for index in 0..<allShapeletWeights.count {
                entries.append(BarChartDataEntry(x: Double(index), y: allShapeletWeights[index].value))
            }
            return entries
        }()
        let entryArr = getHistogramEntry()
        let str:String = {
            var str = ""
            for index in 0..<entryArr.1.count {
                str += "\nIntervals: \(entryArr.1[index])"
            }
            return str
        }()
        
        VStack{
            MultiTimeseriesLine(selectedShapelet: $selectedShapelet, timeseriesArr: $timeseriesArr)
            Divider()
            HStack{
                HBar(entries: entries)
                
                Divider()
                
                VBar(entriesArr: entryArr.0)
                //                [
                //                    // x - position of a VBar, y - height of a VBar
                //                    [BarChartDataEntry(x: 1, y: 1),
                //                     BarChartDataEntry(x: 2, y: 1),
                //                     BarChartDataEntry(x: 3, y: 1),
                //                     BarChartDataEntry(x: 4, y: 1),
                //                     BarChartDataEntry(x: 5, y: 1)]
                //                ]
                Divider()
                Text("Debug:\n" + str)
            }
            .frame(height: 400, alignment: .center)
        }
        .padding()
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
            
            distanceDetailsWithLabel.forEach { distanceDetail in
                //
                for index in 1..<numOfBins+1 {
                    let binVal = Double(index)/25*interval
                    let distance: Double = distanceDetail.distance
                    
                    if distance < binVal+min {
                        count[index-1] += 1
                        break
                    }
                    
                    // Handle the last element which is not included into the count[lastIndex]
//                    if index == (numOfBins+1)-1 {
//                        count[index-1] += 1
//                    }
                }
            }
            
            //
            for index in 0..<count.count {
                let val = count[index]
                let binVal = Double(index)*intervalUnit
                let allCount = Double(distanceDetailsWithLabel.count)
                let sequence = Double(val)/allCount
                entries.append(BarChartDataEntry(x: Double(index), y: sequence))
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

struct TabDetails_Previews: PreviewProvider {
    static var previews: some View {
        TabDetails(selectedTimeseries: .constant(Database.shared.defaultTimeseries), selectedShapelet: .constant(Database.shared.defaultShapelet), timeseriesArr: .constant([Database.shared.defaultTimeseries]))
    }
}

//
