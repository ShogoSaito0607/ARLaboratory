
import SwiftUI
import RealityKit

struct ARViewController: UIViewRepresentable {

    func makeUIView(context: Context) -> ARView {
        return ARDataModel.shared.arView
    }

    func updateUIView(_ uiView: ARView, context: Context) {}

}
