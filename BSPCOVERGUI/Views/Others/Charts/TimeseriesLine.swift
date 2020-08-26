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
        let ys = selectedTimeseries?.values ?? Database.shared.allTimeseries[0].values
        let yse = ys.enumerated().map { x, y in return ChartDataEntry(x: Double(x), y: y) }
        let data = LineChartData()
        let ds = LineChartDataSet(entries: yse, label: selectedTimeseries?.name ?? "Hello")
        ds.colors = [NSUIColor.red]
        data.addDataSet(ds)
        
        return data
    }
    
    typealias NSViewType = LineChartView
}

struct Line_Previews: PreviewProvider {
    static var previews: some View {
        TimeseriesLine(selectedTimeseries: .constant(Database.shared.allTimeseries[0]))
    }
}
