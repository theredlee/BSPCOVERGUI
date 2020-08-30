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
    @Binding var entryArr: [[BarChartDataEntry]]?
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
        //        let str:String = {
        //            var str = ""
        //            for index in 0..<entryArr.1.count {
        //                str += "\nIntervals: \(entryArr.1[index])"
        //            }
        //            return str
        //        }()
        
        VStack{
            MultiTimeseriesLine(selectedShapelet: $selectedShapelet, timeseriesArr: $timeseriesArr)
            Divider()
            HStack{
                HBar(entries: entries)
                
                Divider()
                
                VBar(entriesArr: $entryArr)
                //                [
                //                    // x - position of a VBar, y - height of a VBar
                //                    [BarChartDataEntry(x: 1, y: 1),
                //                     BarChartDataEntry(x: 2, y: 1),
                //                     BarChartDataEntry(x: 3, y: 1),
                //                     BarChartDataEntry(x: 4, y: 1),
                //                     BarChartDataEntry(x: 5, y: 1)]
                //                ]
                Divider()
                //                Text("Debug:\n" + str)
            }
            .frame(height: 400, alignment: .center)
        }
        .padding()
    }
}

struct TabDetails_Previews: PreviewProvider {
    static var previews: some View {
        TabDetails(selectedTimeseries: .constant(Database.shared.defaultTimeseries), selectedShapelet: .constant(Database.shared.defaultShapelet), timeseriesArr: .constant([Database.shared.defaultTimeseries]), entryArr: .constant([[BarChartDataEntry(x: 0, y: 0)]]))
    }
}

//
