
import SwiftUI
import ARKit
import SceneKit

struct FaceARViewControllerWrapper: UIViewControllerRepresentable {
    typealias UIViewControllerType = FaceARViewController
    // structのprivate letはinit定義することで解消される
    private let vm: FaceARViewModel!

    init(vm: FaceARViewModel) {
        self.vm = vm
    }

    func makeUIViewController(context: UIViewControllerRepresentableContext<FaceARViewControllerWrapper>) -> FaceARViewController {
        print("makeUIViewController")
        return FaceARViewController(viewModel: vm)
    }

    func updateUIViewController(_ uiViewController: FaceARViewController,
                                context: UIViewControllerRepresentableContext<FaceARViewControllerWrapper>) {
    }

}

// 特定のタスクに基づいて、UIViewControllerクラスのサブクラス(=FaceARViewController)をインスタンス化します。
// 今回の場合であればWrapperがmakeUIViewControllerからインスタンス化するわけです。
// サブクラスの主目的は画面制御と、Delegate（イベント通知）です。
final class FaceARViewController: UIViewController, ARSCNViewDelegate {
    private var viewModel : FaceARViewModel!

    // 独自のinitを定義する場合はサブクラスでもrequiredも必要になる
    // nibもまたStoryBoard利用時に使うものだそうで、便宜的に入れなくてはならないがSwiftUIの場合不要なのでnilでよい
    required init(viewModel: FaceARViewModel) {
        super.init(nibName: nil, bundle: nil)
        self.viewModel = viewModel
    }

    // Storyboard/xib から初期化はここから走る SwiftUIの場合不要なので適当でよい
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Set the view's delegate
        viewModel.sceneView.delegate = self
        // Show statistics such as fps and timing information
        viewModel.sceneView.showsStatistics = true

        // デバッグ時用オプション
        // ARKitが感知しているところに「+」がいっぱい出てくるようになる
        viewModel.sceneView.debugOptions = ARSCNDebugOptions.showFeaturePoints

        // UIViewControllerを利用する場合はaddSubViewしないと画面にカメラを表示できない
        view.addSubview(viewModel.sceneView)
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupFaceTracking()
    }

    private func setupWorldTracking() {
        // Create a session configuration
        let configuration = ARWorldTrackingConfiguration()
        // ARKit用。平面を検知するように指定
        configuration.planeDetection = .horizontal
        // 現実の環境光に合わせてレンダリングしてくれる
        configuration.isLightEstimationEnabled = true

        // Run the view's session
        print("setupWorldTracking run")
        viewModel.sceneView.session.run(configuration)
    }

    private func setupFaceTracking() {
        guard ARFaceTrackingConfiguration.isSupported else {
            return
        }
        // Create a session configuration
        // SessionをFaceTrackingで開始すると利用カメラが勝手にフロントに指定される
        let configuration = ARFaceTrackingConfiguration()
        // Trueじゃないとマスクに色が反映されない
        configuration.isLightEstimationEnabled = true

        print("setupFaceTracking run")
        viewModel.sceneView.session.run(configuration, options: [.resetTracking, .removeExistingAnchors])
    }

    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        print("pause")
        viewModel.sceneView.session.pause()
    }

    // 新しくアンカーが追加されたら呼ばれる
    func renderer(_ renderer: SCNSceneRenderer, didAdd node: SCNNode, for anchor: ARAnchor) {
        guard anchor is ARFaceAnchor else { return }
        print("anchor didAdd: \(anchor)")
        viewModel.initFaceNode(node)
    }
    // オブジェクト（または他のオブジェクト）が一時停止していない限り、このメソッドをフレームごとに呼び出す
    func renderer(_ renderer: SCNSceneRenderer, didUpdate node: SCNNode, for anchor: ARAnchor) {
        guard let faceAnchor = anchor as? ARFaceAnchor else { return }
        print("anchor didUpdate: \(faceAnchor)")
        viewModel.updateFaceNode(faceAnchor)
    }

    func renderer(_ renderer: SCNSceneRenderer, didRemove node: SCNNode, for anchor: ARAnchor) {
        print("anchor didRemove: \(anchor)")
    }

    func renderer(_ renderer: SCNSceneRenderer, didRenderScene scene:
        SCNScene, atTime time: TimeInterval) {
        print("didRenderScene")
    }
}

