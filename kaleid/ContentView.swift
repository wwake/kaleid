import CoreMotion
import PhotosUI
import SwiftUI

struct ContentView: View {
  @State private var angle: Angle = .degrees(0)
  @State private var mirrors = 10
  @State private var sineRepeats = 3

  @State var motionManager: CMMotionManager!

  @State var selectedPhoto: PhotosPickerItem?

  struct PhotosSelector: View {
    @Binding var selectedPhoto: PhotosPickerItem?

    var body: some View {
      PhotosPicker(
        selection: $selectedPhoto,
        matching: .images
      ) {
        Text("Select a Photo")
      }
    }
  }

  var rotation: some Gesture {
    RotateGesture()
      .onChanged { value in
        angle = value.rotation
      }
  }

  var body: some View {
    TabView {
      GeometryReader { geometry in
        VStack {
          VStack {
            KaleidView(count: mirrors) {
              Image("demo")
                .resizable()
                .padding(-20.0)
                .offset(
                  x: angle.toXOffset(geometry.size),
                  y: angle.toYOffset(geometry.size, repeats: sineRepeats)
                )
            }
            .gesture(rotation)

            PhotosSelector(selectedPhoto: $selectedPhoto)
          }
        }
      }
      .tabItem {
        Label("Photos", systemImage: "photo")
      }

      Text("Camera")
        .tabItem {
          Label("Camera", systemImage: "camera")
        }

      Text("Shapes TBD")
        .tabItem {
          Label("Shapes", systemImage: "light.recessed.3")
        }

      ExperimentView()
        .tabItem {
          Label("Experiment", systemImage: "paperplane")
        }
    }
    .onAppear {
      motionManager = CMMotionManager()
      motionManager.deviceMotionUpdateInterval = TimeInterval(0.05)
      motionManager.startDeviceMotionUpdates(to: OperationQueue.main, withHandler: motionUpdateHandler)
    }
    .onChange(of: selectedPhoto) { value in
      print("photo selection changed")
      print(selectedPhoto)
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
