import SwiftUI

enum ActiveTab: Hashable {
  case photo, camera, experiment
}

struct ContentView: View {
  @State private var activeTab = ActiveTab.photo
  @StateObject private var camera = CameraModel()

  var body: some View {
    TabView(selection: $activeTab) {
      PhotoKaleidoscope()
      .tabItem {
        Label("Photos", systemImage: "photo")
      }
      .tag(ActiveTab.photo)

      CameraKaleidoscope(camera: camera)
        .tabItem {
          Label("Camera", systemImage: "camera")
        }
        .tag(ActiveTab.camera)

      VStack {
        Text(verbatim: "\(activeTab)")
        ExperimentView()
      }
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

#Preview {
  ContentView()
}
