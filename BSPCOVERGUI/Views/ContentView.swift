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
    
    var body: some View {
        NavigationView {
            NavigationPrimary(selectedTimeseries: $selectedTimeseries, selectedTimeseriesLabel: $selectedTimeseriesLabel, selectedShapelet: $selectedShapelet, selectedShapeletLabel: $selectedShapeletLabel)
            
            TabOverall(selectedTimeseries: $selectedTimeseries, selectedShapelet: $selectedShapelet)
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
