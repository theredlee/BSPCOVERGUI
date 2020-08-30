//
//  VVBar.swift
//  BSPCOVERGNS
//
//  Created by TheRedLee on 8/24/20.
//

import SwiftUI
import Charts

struct VBar : NSViewRepresentable {
    let colors: [NSColor] = [.red, .blue, .green, .white, .orange, .purple, .yellow]
    //VBar chart accepts data as array of BarChartDataEntry objects
    var entriesArr : [[BarChartDataEntry]]
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
        
        for index in 0..<entriesArr.count {
            if index == 0 {
                let entries = entriesArr[index]
                //BarChartDataSet is an object that contains information about your data, styling and more
                let dataSet = BarChartDataSet(entries: entries)
                
                //            let dataset2 = BarChartDataSet(entries: [BarChartDataEntry(x: 2, y: 3)])
                //            dataset2.colors = [NSUIColor.red]
                //            dataset2.label = "My Data"
                
                // change VBars color to green
                dataSet.colors = [self.colors[index % 8].withAlphaComponent(0.7)]
                //change data label
                dataSet.label = "My Data"
                
                //            data.addDataSet(dataset2)
                data.addDataSet(dataSet)
            }else{
                break
            }
        }
        
        return data
    }
    
    typealias NSViewType = BarChartView
    
}



struct VBar_Previews: PreviewProvider {
    static var previews: some View {
        VBar(entriesArr: [
            //x - position of a VBar, y - height of a VBar
            [BarChartDataEntry(x: 1, y: 1),
             BarChartDataEntry(x: 2, y: 1),
             BarChartDataEntry(x: 3, y: 1),
             BarChartDataEntry(x: 4, y: 1),
             BarChartDataEntry(x: 5, y: 1)]
        ])
    }
}
