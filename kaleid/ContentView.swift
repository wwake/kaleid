import SwiftUI

enum ActiveTab: Hashable {
  case photo, camera, experiment
}

struct ContentView: View {
  @State private var activeTab = ActiveTab.photo
  @StateObject private var camera = CameraModel()
  @State private var angle: Angle = .degrees(0)

  var body: some View {
    RotatedView(angle: $angle) {
      TabView(selection: $activeTab) {
        PhotoKaleidoscope(angle: angle)
          .tabItem {
            Label("Photos", systemImage: "photo")
          }
          .tag(ActiveTab.photo)
        
        CameraKaleidoscope(camera: camera)
          .tabItem {
            Label("Camera", systemImage: "camera")
          }
          .tag(ActiveTab.camera)
        
        ExperimentView(angle: $angle)
          .tabItem {
            Label("Experiment", systemImage: "paperplane")
          }
          .tag(ActiveTab.experiment)
      }
      .onChange(of: activeTab) {
        if activeTab == .camera {
          camera.startSession()
        } else {
          camera.stopSession()
        }
      }
    }
  }
}

#Preview {
  ContentView()
}
