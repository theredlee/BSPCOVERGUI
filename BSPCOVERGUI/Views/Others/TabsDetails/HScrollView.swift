//
//  Carousel.swift
//  BSPCOVERGUI
//
//  Created by TheRedLee on 8/27/20.
//

import SwiftUI

struct HScrollView: View {
    @Binding var selectedShapelet: Shapelet?
    
    var body: some View {
        ScrollView(.vertical, showsIndicators: false){
            VStack(spacing: 20) {
                ForEach(0..<10) { index in
                    ShapeletLine(selectedShapelet: $selectedShapelet)
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

struct HScrollView_Previews: PreviewProvider {
    static var previews: some View {
        HScrollView(selectedShapelet: .constant(Database.shared.allShapelets[0]))
    }
}
