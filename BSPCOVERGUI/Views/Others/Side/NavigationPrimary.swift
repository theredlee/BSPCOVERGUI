//
//  NavigationPrimary.swift
//  BSPCOVERGUI
//
//  Created by TheRedLee on 8/25/20.
//

import SwiftUI

struct NavigationPrimary: View {
    @Binding var str: String
    @Binding var selectedTimeseries: Timeseries?
    @Binding var selectedTimeseriesLabel: Label?
    @Binding var selectedShapelet: Shapelet?
    @Binding var selectedShapeletLabel: Label?
    
    var body: some View {
        VStack {
            LoadTimeseries(selectedTimeseries: $selectedTimeseries, str: $str, selectedTimeseriesLabel: $selectedTimeseriesLabel)
            
            SideBarFilter(selectedTimeseriesLabel: $selectedTimeseriesLabel)
                .controlSize(.small)
                .padding([.top, .leading], 8)
                .padding(.trailing, 4)
            
            SideBarListTimeseries(selectedTimeseries: $selectedTimeseries, selectedTimeseriesLabel: $selectedTimeseriesLabel)
                .listStyle(SidebarListStyle())
            
            Divider()
            
            LoadShapelet(selectedTimeseries: $selectedTimeseries, selectedShapelet: $selectedShapelet, selectedShapeletLabel: $selectedShapeletLabel, str: $str)

            SideBarListShapelet(selectedShapelet: $selectedShapelet, selectedShapeletLabel: $selectedShapeletLabel)
            
            Divider()
            
            Console(str: $str)
        }
        .frame(minWidth: 225, maxWidth: 300)
        .onChange(of: selectedTimeseries, perform: { value in
            //
        })
    }
}

struct NavigationPrimary_Previews: PreviewProvider {
    static var previews: some View {
        NavigationPrimary(str: .constant("Navigation Bar Started."), selectedTimeseries: .constant(Database.shared.defaultTimeseries), selectedTimeseriesLabel: .constant(Database.shared.defaultTimeseriesLabel), selectedShapelet: .constant(Database.shared.defaultShapelet), selectedShapeletLabel: .constant(Database.shared.defaultShapeletLabel))
    }
}
