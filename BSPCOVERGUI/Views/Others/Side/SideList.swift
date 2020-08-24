//
//  SideList.swift
//  BSPCOVERGUI
//
//  Created by TheRedLee on 8/24/20.
//

import SwiftUI

struct SideList: View {
    
    var body: some View {

        List()  {
            ForEach(Database.values) { timeseries in
                            SideRow(timeseries: timeseries)
                        }
        }
    }
}

struct SideList_Previews: PreviewProvider {
    static var previews: some View {
        SideList()
    }
}
