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
    
    var body: some View {
        VStack{
            MultiTimeseriesLine(selectedShapelet: $selectedShapelet, timeseriesArr: $timeseriesArr)
            Divider()
            VBar(entries: [
                //x - position of a VBar, y - height of a VBar
                BarChartDataEntry(x: 1, y: 1),
                BarChartDataEntry(x: 2, y: 1),
                BarChartDataEntry(x: 3, y: 1),
                BarChartDataEntry(x: 4, y: 1),
                BarChartDataEntry(x: 5, y: 1)
            ])
            .frame(width: 600, height: 400, alignment: .center)
        }
        .padding()
    }
}

struct TabDetails_Previews: PreviewProvider {
    static var previews: some View {
        TabDetails(selectedTimeseries: .constant(Database.shared.defaultTimeseries), selectedShapelet: .constant(Database.shared.defaultShapelet), timeseriesArr: .constant([Database.shared.defaultTimeseries]))
    }
}

//
