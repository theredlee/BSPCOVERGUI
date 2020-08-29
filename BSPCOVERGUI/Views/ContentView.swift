//
//  ContentView.swift
//  BSPCOVERGUI
//
//  Created by TheRedLee on 8/24/20.
//

import SwiftUI

struct ContentView: View {
    @State private var selectedTimeseries: Timeseries?
    @State var selectedTimeseriesLabel: Label?
    @State var selectedShapelet: Shapelet?
    @State var selectedShapeletLabel: Label?
    @State var str: String = "Content View Started"
    @State var timeseriesArr: [Timeseries]?
    let numOfTimeserie: Int = 10
    
    var body: some View {
//        let timeseriesArr = DatabaseManager.shared.getTopKTimeseries(defaultTopK: numOfTimeserie, shapelet: selectedShapelet ?? Database.shared.defaultShapelet)
        
        NavigationView {
            NavigationPrimary(str: $str, selectedTimeseries: $selectedTimeseries, selectedTimeseriesLabel: $selectedTimeseriesLabel, selectedShapelet: $selectedShapelet, selectedShapeletLabel: $selectedShapeletLabel)
            
            //            TabOverall(selectedTimeseries: $selectedTimeseries, selectedShapelet: $selectedShapelet)
            Carousel(selectedTimeseries: $selectedTimeseries, selectedTimeseriesLabel: $selectedTimeseriesLabel, selectedShapelet: $selectedShapelet, selectedShapeletLabel: $selectedShapeletLabel, timeseriesArr: $timeseriesArr, str: $str)
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
        })
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
