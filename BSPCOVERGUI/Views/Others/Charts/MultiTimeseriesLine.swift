//
//  Carousel.swift
//  BSPCOVERGUI
//
//  Created by TheRedLee on 8/27/20.
//

import SwiftUI
import Charts

struct MultiTimeseriesLine: View {
    @Binding var selectedShapelet: Shapelet?
    @Binding var timeseriesArr: [Timeseries]?
    let numOfTimeserie: Int = 10
    
    var body: some View {
        
        ScrollView(.horizontal, showsIndicators: false){
            HStack(spacing: 20) {
                ForEach(0..<numOfTimeserie) { index in
                    let count = timeseriesArr?.count ?? 1
                    let realCount = count-1
                    let realIndex = (index <= realCount ? index : realCount)
                    SingleTimeseriesLine(selectedTimeseries: timeseriesArr?[realIndex])
                    //                    Text("Item \(index)")
                    .foregroundColor(.white)
                    .font(.largeTitle)
                    // fixed frame for carousel list...
                    .frame(width: 400, height: 260)
                    .background(Color.clear)
                }
            }
        }
    }
}

struct MultiTimeseriesLine_Previews: PreviewProvider {
    static var previews: some View {
        MultiTimeseriesLine(selectedShapelet: .constant(Database.shared.defaultShapelet), timeseriesArr: .constant([Database.shared.defaultTimeseries]))
    }
}
