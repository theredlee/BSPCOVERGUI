//
//  SideRow.swift
//  BSPCOVERGUI
//
//  Created by TheRedLee on 8/24/20.
//

import SwiftUI

struct SideBarRow: View {
    
    var timeseries: Timeseries
    
    var body: some View {
        
        VStack(alignment: .leading) {
            
            Text(timeseries.name)
                .fontWeight(.bold)
                .truncationMode(.tail)
                .frame(minWidth: 20)
            
            Text("Label - \(timeseries.label)")
                .font(.caption)
                .opacity(0.625)
                .truncationMode(.middle)
        }
    }
}

//struct SideRow_Previews: PreviewProvider {
//    static var previews: some View {
//        SideRow(timeseries: Timeseries(id: 0, name: "timeseries - 0", values: [Double]))
//    }
//}
