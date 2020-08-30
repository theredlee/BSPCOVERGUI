//
//  LineChartSwiftUIView.swift
//  BSPCOVERGUI
//
//  Created by TheRedLee on 8/24/20.
//

import SwiftUI
import Charts

struct TimeseriesLine: NSViewRepresentable {
    // Plotting in IOS using Charts framework with SwiftUI | by Evgeny Basisty | Medium
    // Line chart accepts data as array of BarChartDataEntry objects
    @Binding var selectedTimeseries: Timeseries?
    @Binding var selectedShapelet: Shapelet?
    
    func makeNSView(context: Context) -> LineChartView {
        //it is convenient to form chart data in a separate func
        let chart = LineChartView()
        chart.data = addData(values: selectedTimeseries?.values ?? [0])
        return chart
    }
    
    func updateNSView(_ nsView: LineChartView, context: Context) {
        //when data changes chartd.data update is required
        nsView.data = addData(values: selectedTimeseries?.values ?? [0])
    }
    
    func addData(values: [Double]) -> LineChartData{
        
        let timeseries = selectedTimeseries ?? Database.shared.defaultTimeseries
        let shapelet = selectedShapelet ?? Database.shared.defaultShapelet
        
        let data = LineChartData()
        
        let ys1 = timeseries.values
        let yse1 = ys1.enumerated().map { x, y in return ChartDataEntry(x: Double(x), y: y) }
        let ds1 = LineChartDataSet(entries: yse1, label: timeseries.name )
        ds1.colors = [NSUIColor.red]
        
        let getIndexDistance = DatabaseManager.shared.getDistanceFromMap(timeseries: timeseries, shapelet: shapelet)
        var index: Int
        if getIndexDistance.0 == -1 {
            index = getIndexDistance.1
        }else {
            index = getIndexDistance.1
        }
        
        let ys2 = shapelet.values
        let yse2 = ys2.enumerated().map { x, y in return ChartDataEntry(x: Double(x+index), y: y) }
        let ds2 = LineChartDataSet(entries: yse2, label: shapelet.name )
        ds2.colors = [NSUIColor.blue]
        
        //        // Do any additional setup after loading the view.
        //        let ys3 = Array(1..<10).map { x in return sin(Double(x) / 2.0 / 3.141 * 1.5) }
        //        let ys4 = Array(1..<10).map { x in return cos(Double(x) / 2.0 / 3.141) }
        //
        //        let yse3 = ys3.enumerated().map { x, y in return ChartDataEntry(x: Double(x+2), y: y) }
        //        let yse4 = ys4.enumerated().map { x, y in return ChartDataEntry(x: Double(x+2), y: y) }
        //        let ds1 = LineChartDataSet(entries: yse3, label: "Hello")
        //        ds1.colors = [NSUIColor.red]
        //        let ds2 = LineChartDataSet(entries: yse4, label: "World")
        //        ds2.colors = [NSUIColor.blue]
        //        data.addDataSet(ds1)
        //        data.addDataSet(ds2)
        
        data.addDataSet(ds1)
        data.addDataSet(ds2)
        
        return data
    }
    
    typealias NSViewType = LineChartView
}

struct Line_Previews: PreviewProvider {
    static var previews: some View {
        TimeseriesLine(selectedTimeseries: .constant(Database.shared.defaultTimeseries), selectedShapelet: .constant(Database.shared.defaultShapelet))
    }
}
