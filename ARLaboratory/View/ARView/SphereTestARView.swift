//
//  SphereTestARView.swift
//  ARLaboratory
//
//  Created by ShogoSaito on 2020/04/24.
//  Copyright © 2020 bitkey. All rights reserved.
//

import SwiftUI
import RealityKit

struct SphereTestARView: View {
    private let dataModel = ARDataModel.shared
    var body: some View {
        ZStack {
            ARViewController()
                .edgesIgnoringSafeArea(.all)
            VStack {
                Spacer()
                HStack {
                    Button(action: {
                        self.dataModel.addSphere()
                    }) {
                        Text("球体追加")
                            .frame(width: UIScreen.main.bounds.width * 0.35,
                                   height: UIScreen.main.bounds.height * 0.1)
                            .background(Color.yellow)
                            .cornerRadius(20)
                    }
                    Button(action: {
                        self.dataModel.removeAllAnchor()
                    }) {
                        Text("球体全削除")
                            .frame(width: UIScreen.main.bounds.width * 0.35,
                                   height: UIScreen.main.bounds.height * 0.1)
                            .background(Color.yellow)
                            .cornerRadius(20)
                    }
                }
            }
        }
    }
}

#if DEBUG
struct SphereTestARView_Previews: PreviewProvider {
    static var previews: some View {
        SphereTestARView()
    }
}
#endif
