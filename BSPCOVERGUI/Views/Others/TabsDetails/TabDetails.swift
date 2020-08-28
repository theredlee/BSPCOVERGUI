//
//  TabDetails.swift
//  BSPCOVERGUI
//
//  Created by TheRedLee on 8/24/20.
//

import SwiftUI
import Charts

struct TabDetails: View {
    var body: some View {
        VStack{
            HStack{
                VBar(entries: [
                    //x - position of a VBar, y - height of a VBar
                    BarChartDataEntry(x: 1, y: 1),
                    BarChartDataEntry(x: 2, y: 1),
                    BarChartDataEntry(x: 3, y: 1),
                    BarChartDataEntry(x: 4, y: 1),
                    BarChartDataEntry(x: 5, y: 1)
                ])
            }
            .padding()
        }
    }
}

struct TabDetails_Previews: PreviewProvider {
    static var previews: some View {
        TabDetails()
    }
}
