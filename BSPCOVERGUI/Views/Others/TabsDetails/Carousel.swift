//
//  Carousel.swift
//  BSPCOVERGUI
//
//  Created by TheRedLee on 8/27/20.
//

import SwiftUI

struct Carousel: View {
    @Binding var selectedTimeseries: Timeseries?
    @Binding var selectedTimeseriesLabel: Label?
    @Binding var selectedShapelet: Shapelet?
    @Binding var selectedShapeletLabel: Label?
    @Binding var timeseriesArr: [Timeseries]?
    @Binding var str: String
    let colors: [Color] = [.white, .red, .green, .blue, .orange, .pink, .purple, .yellow]
    
    var body: some View {
        GeometryReader { fullView in
            ScrollView(.horizontal, showsIndicators: false) {
                HStack {
                    //                    ForEach(0..<3) { index in
                    GeometryReader { geo in
                        TabBSPCOVERRun(str: $str)
                        
                    }
                    .frame(width: fullView.size.width)
                    
                    GeometryReader { geo in
                        TabOverall(selectedTimeseries: $selectedTimeseries, selectedShapelet: $selectedShapelet)
                            .frame(height: fullView.size.height)
                            .transformEffect(CGAffineTransform(rotationAngle: 0))
                        
                    }
                    .frame(width: fullView.size.width)
                    
                    //                    GeometryReader { geo in
                    //                        Rectangle()
                    //                            .fill(self.colors[0 % 8])
                    //                            .frame(height: fullView.size.height)
                    //                            //                                    .rotation3DEffect(.degrees(-Double(geo.frame(in: .global).midX - fullView.size.width / 2) / 10), axis: (x: 0, y: 1, z: 0))
                    //                            .transformEffect(CGAffineTransform(rotationAngle: 0))
                    //
                    //                    }
                    //                    .frame(width: fullView.size.width)
                    
                    GeometryReader { geo in
                        TabDetails(selectedTimeseries: .constant(Database.shared.defaultTimeseries), selectedShapelet: .constant(Database.shared.defaultShapelet), timeseriesArr: $timeseriesArr)
                    }
                    .frame(width: fullView.size.width)
                    //                    }
                }
                //                    .padding(.horizontal, (fullView.size.width - 150) / 2)
                .padding(.horizontal, 0)
            }
        }
        .edgesIgnoringSafeArea(.all)
    }
}

struct Carousel_Previews: PreviewProvider {
    static var previews: some View {
        Carousel(selectedTimeseries: .constant(Database.shared.defaultTimeseries), selectedTimeseriesLabel: .constant(Database.shared.defaultTimeseriesLabel), selectedShapelet: .constant(Database.shared.defaultShapelet), selectedShapeletLabel: .constant(Database.shared.defaultShapeletLabel), timeseriesArr: .constant([Database.shared.defaultTimeseries]), str: .constant("This is Carousel."))
    }
}
