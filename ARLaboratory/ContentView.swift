//
//  ContentView.swift
//  ARLaboratory
//
//  Created by ShogoSaito on 2020/04/24.
//  Copyright © 2020 bitkey. All rights reserved.
//

import SwiftUI
import RealityKit

struct ContentView : View {
    var body: some View {
        return TopMenu()
    }
}

#if DEBUG
struct ContentView_Previews : PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
#endif
