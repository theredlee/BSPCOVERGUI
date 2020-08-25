//
//  SideList.swift
//  BSPCOVERGUI
//
//  Created by TheRedLee on 8/24/20.
//

import SwiftUI

struct SideBarList: View {
    @Binding var selectedTimeseries: Timeseries?
    @Binding var filter: FilterType
    
    var body: some View {
        //        List(Database.values, id: \.self, selection: $selectedTimeseries) { timeseries in
        List(selection: $selectedTimeseries) {
            ForEach(Database.values) { timeseries in
                if (self.filter.label == timeseries.label.value) {
                    SideBarRow(timeseries: timeseries).tag(timeseries)
                }
            }
        }
    }
}

struct SideList_Previews: PreviewProvider {
    static var previews: some View {
        SideBarList(selectedTimeseries: .constant(Database.defaultValue), filter: .constant(.defaultType))
    }
}
