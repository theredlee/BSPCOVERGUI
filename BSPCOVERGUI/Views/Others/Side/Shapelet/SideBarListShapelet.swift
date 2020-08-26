//
//  SideBarListShapelet.swift
//  BSPCOVERGUI
//
//  Created by TheRedLee on 8/26/20.
//

import SwiftUI

struct SideBarListShapelet: View {
    @Binding var selectedShapelet: Shapelet?
    @Binding var selectedShapeletLabel: Label?
    
    var body: some View {
        List(selection: $selectedShapelet) {
            ForEach(Database.shared.allShapelets) { shapelet in
                if (selectedShapeletLabel?.value == shapelet.label.value) {
                    SideBarRowShapelet(shapelet: shapelet).tag(shapelet)
                }
            }
        }
    }
}

struct SideBarListShapelet_Previews: PreviewProvider {
    static var previews: some View {
        SideBarListShapelet(selectedShapelet: .constant(Database.shared.defaultShapelet), selectedShapeletLabel: .constant(Database.shared.defaultShapeletLabel))
    }
}
