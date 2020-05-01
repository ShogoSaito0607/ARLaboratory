
import ARKit
import SwiftUI

final class FaceARViewModel: ObservableObject {
    @Published var sceneView: ARSCNView!
    private var faceNode: SCNNode?
    var virtualFaceNode: VirtualFaceNode? {
        didSet {
            setupFaceNodeContent()
        }
    }

    init() {
        // .zeroだとカメラ面積が0になるようで白背景になる
        sceneView = ARSCNView(frame: UIScreen.main.bounds)
        virtualFaceNode = createFaceNode()
    }

    func initFaceNode(_ node: SCNNode) {
        faceNode = node
        DispatchQueue.main.async {
            self.setupFaceNodeContent()
        }
    }

    //顔の動きに合わせてマスクをアップデートする
    func updateFaceNode(_ faceAnchor: ARFaceAnchor) {
        virtualFaceNode?.update(withFaceAnchor: faceAnchor)
    }

    private func setupFaceNodeContent() {
        guard let faceNode = faceNode else { return }
        for child in faceNode.childNodes {
            child.removeFromParentNode()
        }
        if let content = virtualFaceNode {
            faceNode.addChildNode(content)
        }
    }

    private func createFaceNode() -> VirtualFaceNode? {
        guard let device = sceneView.device, let geometry = ARSCNFaceGeometry(device: device) else {
            return nil
        }
        return Mask(geometry: geometry)
    }
}

extension ARSCNView {

    /// 現実世界の座標に変換
    ///
    /// - Parameter screenPosition: CGPoint
    /// - Returns: SCNVector3
    func realWorldVector(screenPosition: CGPoint) -> SCNVector3? {
        let results = self.hitTest(screenPosition, types: [.existingPlane])
        guard let result = results.first else {
            return nil
        }

        // SCNVector3
        return SCNVector3(result.worldTransform.columns.3.x, result.worldTransform.columns.3.y, result.worldTransform.columns.3.z)
    }
}
