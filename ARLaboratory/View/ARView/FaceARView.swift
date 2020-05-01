
import SwiftUI
import RealityKit

struct FaceARView: View {
    private let vm: FaceARViewModel = FaceARViewModel()

    var body: some View {
        FaceARViewControllerWrapper(vm: vm)
            .edgesIgnoringSafeArea(.all)
    }
}

struct FaceARView_Previews: PreviewProvider {
    static var previews: some View {
        FaceARView()
    }
}
