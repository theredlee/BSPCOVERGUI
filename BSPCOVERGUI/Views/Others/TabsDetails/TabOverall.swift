//
//  TabOverall.swift
//  BSPCOVERGUI
//
//  Created by TheRedLee on 8/24/20.
//

import SwiftUI

struct TabOverall: View {
    @Binding var selectedTimeseries: Timeseries?
    @Binding var selectedShapelet: Shapelet?
    
    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            HStack(alignment: .center, spacing: 24) {
                
                TimeseriesLine(selectedTimeseries: $selectedTimeseries, selectedShapelet: $selectedShapelet)
                    .frame(width: 700)
            }
            .frame(height: 400)
            .padding()
            
            Divider()
            
            HStack{
                Text("About time series")
                    .font(.headline)
                
                Text(selectedTimeseries?.name ?? "Fail to fetch timeseries")
                    .lineLimit(nil)
                
                Text(selectedTimeseries?.label.name ?? "Fail to fetch timeseries")
                    .lineLimit(nil)
            }
            .padding()
            
            Divider()
            
            HStack{
                ShapeletLine(selectedShapelet: $selectedShapelet)
                    .frame(width: 500)
                
                VStack{
                    HStack{
                        CircleImage(image: Image("Image-1").resizable(), shadowRadius: 4)
                            .frame(width: 160, height: 160)
                        
                        VStack(alignment: .leading) {
                            Text("WINDOW").font(.title)
                            Text("ABC")
                        }
                        .font(.caption)
                    }
                }
                .padding()
                //                    .offset(x: 0, y: -50)
            }
            .padding()
        }
        .padding()
        
    }
}

struct TabOverall_Previews: PreviewProvider {
    static var previews: some View {
        TabOverall(selectedTimeseries: .constant(Database.shared.defaultTimeseries), selectedShapelet: .constant(Database.shared.defaultShapelet))
    }
}
