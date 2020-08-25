//
//  ContentView.swift
//  BSPCOVERGUI
//
//  Created by TheRedLee on 8/24/20.
//

import SwiftUI

struct ContentView: View {
    @State var selectedTimeseries: Timeseries? = Database.defaultValue
    
    var body: some View {
        NavigationView {
            NavigationPrimary(selectedTimeseries: $selectedTimeseries)
            
            if selectedTimeseries != nil {
                TabOverall(timeseries: selectedTimeseries ?? Database.defaultValue)
            }
        }
        .navigationTitle("ABC")
        .frame(minWidth: 700, minHeight: 300)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
