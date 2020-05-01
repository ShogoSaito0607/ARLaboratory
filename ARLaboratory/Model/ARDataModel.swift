
import RealityKit
import SwiftUI

final class ARDataModel: ObservableObject {
    static var shared = ARDataModel()
    @Published var arView: ARView!

    init() {
        arView = ARView(frame: .zero)
//        arView.debugOptions = [.showStatistics, .showFeaturePoints]
    }

    func addSphere() {
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
    }

    func removeAllAnchor() {
        arView.scene.anchors.removeAll()
    }
}
