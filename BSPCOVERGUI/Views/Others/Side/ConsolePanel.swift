//
//  ConsolePanel.swift
//  BSPCOVERGUI
//
//  Created by TheRedLee on 8/25/20.
//

import SwiftUI

struct ConsolePanel: View {
    @Binding var str: String
    
    var body: some View {
        Text(str)
//        TextField("Console", text: $str)
            .frame(height: 170)
    }
}

struct ConsolePanel_Previews: PreviewProvider {
    static var previews: some View {
        ConsolePanel(str: .constant("Console started."))
    }
}
