//
//  ShapeletLine.swift
//  BSPCOVERGUI
//
//  Created by TheRedLee on 8/26/20.
//

import SwiftUI
import Charts

struct ShapeletLine: NSViewRepresentable {
    // Plotting in IOS using Charts framework with SwiftUI | by Evgeny Basisty | Medium
    // Line chart accepts data as array of BarChartDataEntry objects
    @Binding var selectedShapelet: Shapelet?
    
    func makeNSView(context: Context) -> LineChartView {
        //it is convenient to form chart data in a separate func
        let chart = LineChartView()
        chart.data = addData(values: selectedShapelet?.values ?? [0])
        return chart
    }
    
    func updateNSView(_ nsView: LineChartView, context: Context) {
        //when data changes chartd.data update is required
        nsView.data = addData(values: selectedShapelet?.values ?? [0])
    }
    
    func addData(values: [Double]) -> LineChartData{
        let ys = selectedShapelet?.values ?? Database.shared.allShapelets[0].values
        let yse = ys.enumerated().map { x, y in return ChartDataEntry(x: Double(x), y: y) }
        let data = LineChartData()
        let ds = LineChartDataSet(entries: yse, label: selectedShapelet?.name ?? "Hello")
        ds.colors = [NSUIColor.red]
        data.addDataSet(ds)
        
        return data
    }
    
    typealias NSViewType = LineChartView
}

struct ShapeletLine_Previews: PreviewProvider {
    static var previews: some View {
        ShapeletLine(selectedShapelet: .constant(Database.shared.defaultShapelet))
    }
}
