//
//  TestARView.swift
//  ARLaboratory
//
//  Created by ShogoSaito on 2020/04/24.
//  Copyright © 2020 bitkey. All rights reserved.
//

import SwiftUI
import RealityKit

struct TestARView: View {
    var body: some View {
        return TestARViewContainer().edgesIgnoringSafeArea(.all)
    }
}

//ただ球が出てくるだけ
struct TestARViewContainer: UIViewRepresentable {

    func makeUIView(context: Context) -> ARView {

        let arView = ARView(frame: .zero)

        arView.debugOptions = [.showStatistics, .showFeaturePoints]

        let anchor = AnchorEntity(plane: .horizontal, minimumBounds: [0.15, 0.15])
        arView.scene.anchors.append(anchor)

        let sphereMesh = MeshResource.generateSphere(radius: 0.3)
        let sphereMaterial = SimpleMaterial(color: UIColor.white, roughness: 0.0, isMetallic: true)
        let sphereModel = ModelEntity(mesh: sphereMesh, materials: [sphereMaterial])
        sphereModel.position = SIMD3<Float>(0.0, 0.0, 0.0)
        anchor.addChild(sphereModel)
        // Load the "Box" scene from the "Experience" Reality File
        let boxAnchor = try! Experience.loadBox()

        // Add the box anchor to the scene
        arView.scene.anchors.append(boxAnchor)

        return arView

    }

    func updateUIView(_ uiView: ARView, context: Context) {}

}

#if DEBUG
struct TestARView_Previews: PreviewProvider {
    static var previews: some View {
        TestARView()
    }
}
#endif
