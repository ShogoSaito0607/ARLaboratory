//
//  ARViewController.swift
//  ARLaboratory
//
//  Created by ShogoSaito on 2020/04/24.
//  Copyright © 2020 bitkey. All rights reserved.
//

import SwiftUI
import RealityKit

struct ARViewController: UIViewRepresentable {

    func makeUIView(context: Context) -> ARView {
        return ARDataModel.shared.arView
    }

    func updateUIView(_ uiView: ARView, context: Context) {}

}
