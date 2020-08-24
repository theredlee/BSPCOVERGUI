//
//  ContentView.swift
//  BSPCOVERGUI
//
//  Created by TheRedLee on 8/24/20.
//

import SwiftUI

struct ContentView: View {
    
    let sideList: SideList
    
    var body: some View {
//        Text("Hello, world! Hello, world! Hello, world!")
//            .padding()
        sideList
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(sideList: SideList())
    }
}
