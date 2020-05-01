
import ARKit

class Mask: SCNNode, VirtualFaceContent {
    func update(withFaceAnchor: ARFaceAnchor) {
        guard let faceGeometry = geometry as? ARSCNFaceGeometry else { return }
        faceGeometry.update(from: withFaceAnchor.geometry)
    }

    init(geometry: ARSCNFaceGeometry) {
        let material = geometry.firstMaterial
        material?.diffuse.contents = UIColor.white
        material?.lightingModel = .physicallyBased

        super.init()
        self.geometry = geometry
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
