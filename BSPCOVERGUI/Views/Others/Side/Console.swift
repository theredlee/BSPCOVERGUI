//
//  ConsolePanel.swift
//  BSPCOVERGUI
//
//  Created by TheRedLee on 8/25/20.
//

import SwiftUI
import Combine

struct Console: View {
    @Binding var str: String
    
    var body: some View {
        TextEditor(text: $str)
            .frame(height: 165)
            .offset(x: /*@START_MENU_TOKEN@*/10.0/*@END_MENU_TOKEN@*/, y: 0)
    }
}

struct Console_Previews: PreviewProvider {
    static var previews: some View {
        Console(str: .constant("Console started."))
    }
}
