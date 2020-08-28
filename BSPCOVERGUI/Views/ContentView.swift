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
    
    var body: some View {
        NavigationView {
            NavigationPrimary(str: $str, selectedTimeseries: $selectedTimeseries, selectedTimeseriesLabel: $selectedTimeseriesLabel, selectedShapelet: $selectedShapelet, selectedShapeletLabel: $selectedShapeletLabel)
            
            //            TabOverall(selectedTimeseries: $selectedTimeseries, selectedShapelet: $selectedShapelet)
            Carousel(selectedTimeseries: $selectedTimeseries, selectedTimeseriesLabel: $selectedTimeseriesLabel, selectedShapelet: $selectedShapelet, selectedShapeletLabel: $selectedShapeletLabel, str: $str)
        }
        .navigationTitle("BSPCOVERGUI")
        .frame(minWidth: 700, minHeight: 300)
        .onChange(of: selectedTimeseries, perform: { value in
            //
        })
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
