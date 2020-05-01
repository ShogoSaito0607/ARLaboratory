
import SwiftUI
import RealityKit

struct ContentView : View {
    var body: some View {
        return TopMenu()
    }
}

#if DEBUG
struct ContentView_Previews : PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
#endif
