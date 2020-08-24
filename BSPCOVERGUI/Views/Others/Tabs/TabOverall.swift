//
//  TabOverall.swift
//  BSPCOVERGUI
//
//  Created by TheRedLee on 8/24/20.
//

import SwiftUI

struct TabOverall: View {
    
    let lineChart: Line
    
    var body: some View {
//        ScrollView {
//                    VStack(alignment: .leading, spacing: 12) {
//                        HStack(alignment: .center, spacing: 24) {
//
//                            VStack(alignment: .leading) {
//                                lineChart
//                            }
//                            .font(.caption)
//                        }
//                    }
//                    .padding()
//                    .frame(maxWidth: 700)
//                }
        lineChart
    }
}

struct TabOverall_Previews: PreviewProvider {
    static var previews: some View {
        TabOverall(lineChart: Line())
    }
}
