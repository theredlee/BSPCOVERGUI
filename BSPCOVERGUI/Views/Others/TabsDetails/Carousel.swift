//
//  Carousel.swift
//  BSPCOVERGUI
//
//  Created by TheRedLee on 8/27/20.
//

import SwiftUI

struct Carousel: View {
    @State private var selectedTimeseries: Timeseries?
    //    @State var selectedTimeseriesLabel: Label?
    @State var selectedShapelet: Shapelet?
    //    @State var selectedShapeletLabel: Label?
    let colors: [Color] = [.red, .green, .blue, .orange, .pink, .purple, .yellow]
    
    var body: some View {
        GeometryReader { fullView in
            ScrollView(.horizontal, showsIndicators: false) {
                HStack {
                    //                    ForEach(0..<3) { index in
                    GeometryReader { geo in
                        TabOverall(selectedTimeseries: $selectedTimeseries, selectedShapelet: $selectedShapelet)
                            .frame(height: fullView.size.height)
                            .transformEffect(CGAffineTransform(rotationAngle: 0))
                        
                    }
                    .frame(width: fullView.size.width)
                    
                    GeometryReader { geo in
                        Rectangle()
                            .fill(self.colors[1 % 7])
                            .frame(height: fullView.size.height)
                            //                                    .rotation3DEffect(.degrees(-Double(geo.frame(in: .global).midX - fullView.size.width / 2) / 10), axis: (x: 0, y: 1, z: 0))
                            .transformEffect(CGAffineTransform(rotationAngle: 0))
                        
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
        Carousel()
    }
}
