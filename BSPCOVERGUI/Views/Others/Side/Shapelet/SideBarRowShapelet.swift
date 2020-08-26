//
//  SideBarRowShapelet.swift
//  BSPCOVERGUI
//
//  Created by TheRedLee on 8/26/20.
//

import SwiftUI

struct SideBarRowShapelet: View {
    var shapelet: Shapelet
    
    var body: some View {
        VStack(alignment: .leading) {
            
            Text(shapelet.name)
                .fontWeight(.bold)
                .truncationMode(.tail)
                .frame(minWidth: 20)
            
            Text(String(shapelet.label.name))
                .font(.caption)
                .opacity(0.625)
                .truncationMode(.middle)
        }
    }
}

//struct SideBarRowShapelet_Previews: PreviewProvider {
//    static var previews: some View {
//        SideBarRowShapelet()
//    }
//}
