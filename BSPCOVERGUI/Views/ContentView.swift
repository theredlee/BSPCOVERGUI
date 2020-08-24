//
//  ContentView.swift
//  BSPCOVERGUI
//
//  Created by TheRedLee on 8/24/20.
//

import SwiftUI

struct ContentView: View {
    
    let sideList: SideList
    
    let lineChart: Line
    
//    @State private var selectedTimeseries: Timeseries?
    
    var body: some View {
        NavigationView {
            sideList
            
            lineChart
                }
                .frame(minWidth: 700, minHeight: 300)
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(sideList: SideList(), lineChart: Line())
    }
}
