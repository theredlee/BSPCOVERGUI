//
//  Filter.swift
//  BSPCOVERGUI
//
//  Created by TheRedLee on 8/24/20.
//

import SwiftUI

struct SideBarFilter: View {
    @Binding var filter: FilterType
    
    var body: some View {
        HStack {
            Picker(selection: $filter, label: EmptyView()) {
                ForEach(FilterType.allCases) { choice in
                    Text(choice.name).tag(choice)
                }
            }
            
            Spacer()
            //            Toggle(isOn: <#Binding<Bool>#>) {
            //                Text("Favorites only")
            //            }
        }
    }
}

struct Filter_Previews: PreviewProvider {
    static var previews: some View {
        SideBarFilter(filter: .constant(.defaultType))
    }
}


struct FilterType: Hashable, Identifiable {
    
    var label: Int
    var name: String
    
    init(label: Int) {
        self.label = label
        self.name = "label - \(label)"
    }
    
    static var defaultType = FilterType(label: 0)
    
    static var allCases: [FilterType] {
        return Database.allLabels.map(FilterType.init)
    }
    
    var id: FilterType {
        return self
    }
}
