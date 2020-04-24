//
//  TopMenu.swift
//  ARLaboratory
//
//  Created by ShogoSaito on 2020/04/24.
//  Copyright © 2020 bitkey. All rights reserved.
//

import SwiftUI

struct TopMenu: View {
    var body: some View {
        NavigationView{
            VStack(spacing: 5) {
                NavigationLink(destination: TestARView()) {
                        Text("ARViewに球体を表示させる")
                            .frame(width: UIScreen.main.bounds.width * 0.8, height: UIScreen.main.bounds.height * 0.1)
                            .background(Color.blue.opacity(0.3))
                            .cornerRadius(20)
                }
            }
        }
    }
}

struct TopMenu_Previews: PreviewProvider {
    static var previews: some View {
        TopMenu()
    }
}
