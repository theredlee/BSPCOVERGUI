//
//  LineChartSwiftUIView.swift
//  BSPCOVERGUI
//
//  Created by TheRedLee on 8/24/20.
//

import SwiftUI
import Charts

struct Line: NSViewRepresentable {
    // Line chart accepts data as array of BarChartDataEntry objects
//    var entries : [BarChartDataEntry]
    
    func makeNSView(context: Context) -> LineChartView {
        let chart = LineChartView()
        //it is convenient to form chart data in a separate func
        chart.data = addData()
        return chart
    }
    
    func updateNSView(_ nsView: LineChartView, context: Context) {
        //when data changes chartd.data update is required
    }
    
    func addData() -> LineChartData{
        // Do any additional setup after loading the view.
        let ys1 = Array(1..<10).map { x in return sin(Double(x) / 2.0 / 3.141 * 1.5) }
        let ys2 = Array(1..<10).map { x in return cos(Double(x) / 2.0 / 3.141) }
        
        let yse1 = ys1.enumerated().map { x, y in return ChartDataEntry(x: Double(x), y: y) }
        let yse2 = ys2.enumerated().map { x, y in return ChartDataEntry(x: Double(x), y: y) }
        
        let data = LineChartData()
        let ds1 = LineChartDataSet(entries: yse1, label: "Hello")
        ds1.colors = [NSUIColor.red]
        data.addDataSet(ds1)
        
        let ds2 = LineChartDataSet(entries: yse2, label: "World")
        ds2.colors = [NSUIColor.blue]
        data.addDataSet(ds2)
        
        return data
    }
    
    typealias NSViewType = LineChartView
    
    
}

struct Line_Previews: PreviewProvider {
    static var previews: some View {
        Line()
    }
}
