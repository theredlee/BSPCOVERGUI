//
//  NavigationPrimary.swift
//  BSPCOVERGUI
//
//  Created by TheRedLee on 8/25/20.
//

import SwiftUI

struct NavigationPrimary: View {
    @Binding var selectedTimeseries: Timeseries?
    @State private var filter: FilterType = .defaultType
    
    var body: some View {
        VStack {
            SideBarFilter(filter: $filter)
                .controlSize(.small)
                .padding([.top, .leading], 8)
                .padding(.trailing, 4)
            
            SideBarList(selectedTimeseries: $selectedTimeseries, filter: $filter)
                .listStyle(SidebarListStyle())
        }
        .frame(minWidth: 225, maxWidth: 300)
    }
}

struct NavigationPrimary_Previews: PreviewProvider {
    static var previews: some View {
        NavigationPrimary(selectedTimeseries: .constant(Database.defaultValue))
    }
}
