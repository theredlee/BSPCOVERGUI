//
//  HBar.swift
//  BSPCOVERGUI
//
//  Created by TheRedLee on 8/28/20.
//

import SwiftUI
import Charts

struct HBar : NSViewRepresentable {
    //HBar chart accepts data as array of BarChartDataEntry objects
    var entries : [BarChartDataEntry]
    // this func is reqNSred to conform to NSViewRepresentable protocol
    func makeNSView(context: Context) -> BarChartView {
        //crate new chart
        let chart = BarChartView()
        //it is convenient to form chart data in a separate func
        chart.data = addData()
        return chart
    }
    
    // this func is reqNSred to conform to NSViewRepresentable protocol
    func updateNSView(_ NSView: BarChartView, context: Context) {
        //when data changes chartd.data update is reqNSred
        NSView.data = addData()
    }
    
    func addData() -> BarChartData{
        let data = BarChartData()
        //BarChartDataSet is an object that contains information about your data, styling and more
        let dataSet = BarChartDataSet(entries: entries)
        
        // change HBars color to green
        dataSet.colors = [NSColor.blue.withAlphaComponent(0.7)]
        //change data label
        dataSet.label = "My Data"
        
        data.addDataSet(dataSet)
        return data
    }
    
    typealias NSViewType = BarChartView
    
}



struct HBar_Previews: PreviewProvider {
    static var previews: some View {
        HBar(entries: [
            //x - position of a HBar, y - height of a HBar
            BarChartDataEntry(x: 1, y: 1),
            BarChartDataEntry(x: 2, y: 1),
            BarChartDataEntry(x: 3, y: 1),
            BarChartDataEntry(x: 4, y: 1),
            BarChartDataEntry(x: 5, y: 1)

        ])
    }
}
