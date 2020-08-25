//
//  TabOverall.swift
//  BSPCOVERGUI
//
//  Created by TheRedLee on 8/24/20.
//

import SwiftUI

struct TabOverall: View {
    
    let timeseries: Timeseries
    
    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            HStack(alignment: .center, spacing: 24) {
                CircleImage(image: Image("Image-1").resizable())
            }
            Divider()
            
            Text("About time series")
                .font(.headline)
            
            Text(timeseries.name)
                .lineLimit(nil)
            
            Text(timeseries.label.name)
                .lineLimit(nil)
        }
        .padding()
        .frame(maxWidth: 700)
        //        .offset(x: 0, y: -50)
    }
}

struct TabOverall_Previews: PreviewProvider {
    static var previews: some View {
        TabOverall(timeseries: Database.defaultValue)
    }
}
