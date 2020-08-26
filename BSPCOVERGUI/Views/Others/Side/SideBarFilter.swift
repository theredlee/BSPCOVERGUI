//
//  Filter.swift
//  BSPCOVERGUI
//
//  Created by TheRedLee on 8/24/20.
//

import SwiftUI

struct SideBarFilter: View {
    @Binding var selectedTimeseriesLabel: Label?
    
    var body: some View {
        HStack {
            Picker(selection: $selectedTimeseriesLabel, label: Text("Please choose a color")) {
                ForEach(Database.shared.allTimeseriesLabels) { label in
                    Text(label.name).tag(label)
                }
            }
            Spacer()
            //            Toggle(isOn: ) {
            //                Text("Favorites only")
            //            }
        }
    }
}

struct Filter_Previews: PreviewProvider {
    static var previews: some View {
        SideBarFilter(selectedTimeseriesLabel: .constant(Database.shared.defaultTimeseriesLabel))
    }
}
