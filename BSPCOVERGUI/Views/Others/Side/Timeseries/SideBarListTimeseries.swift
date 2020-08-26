//
//  SideList.swift
//  BSPCOVERGUI
//
//  Created by TheRedLee on 8/24/20.
//

import SwiftUI

struct SideBarListTimeseries: View {
    @Binding var selectedTimeseries: Timeseries?
    @Binding var selectedTimeseriesLabel: Label?
    
    var body: some View {
        List(selection: $selectedTimeseries) {
            ForEach(Database.shared.allTimeseries) { timeseries in
                if (selectedTimeseriesLabel?.value == timeseries.label.value) {
                    SideBarRowTimeseries(timeseries: timeseries).tag(timeseries)
                }
            }
        }
    }
}

struct SideList_Previews: PreviewProvider {
    static var previews: some View {
        SideBarListTimeseries(selectedTimeseries: .constant(Database.shared.defaultTimeseries), selectedTimeseriesLabel: .constant(Database.shared.defaultTimeseriesLabel))
    }
}
