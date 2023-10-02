import CoreMotion
import SwiftUI

struct ContentView: View {
  @State private var angle: Angle = .zero
  @State private var mirrors = 10
  @State private var sineRepeats = 3

  @State var motionManager: CMMotionManager!

  var rotation: some Gesture {
    RotateGesture()
      .onChanged { value in
        angle = value.rotation
      }
  }

  var body: some View {
    GeometryReader { geometry in
      VStack {
       // Text("Angle: \(angle.degrees)")
        TabView {
          VStack {
            KaleidView(count: mirrors) {
              Image("demo")
                .resizable()
                .offset(
                  x: angle.toX(geometry.size, mirrors),
                  y: angle.toY(geometry.size, repeats: sineRepeats)
                )
            }
            .gesture(rotation)

            Button("Select...") {
              print("select image")
            }
          }
          .tabItem {
            Label("Photos", systemImage: "photo")
          }

          Text("Camera TBD")
            .tabItem {
              Label("Camera", systemImage: "camera")
            }

          Text("Shapes TBD")
            .tabItem {
              Label("Shapes", systemImage: "light.recessed.3")
            }
        }
      }
    }
    .onAppear {
      motionManager = CMMotionManager()
      motionManager.deviceMotionUpdateInterval = TimeInterval(0.05)
      motionManager.startDeviceMotionUpdates(to: OperationQueue.main, withHandler: motionUpdateHandler)
    }
  }

  func motionUpdateHandler(_ data: CMDeviceMotion?, _ error: Error?) {
    if data == nil || error != nil { return }
    angle = .radians(data!.attitude.yaw)
  }
}

#Preview {
  ContentView()
}
