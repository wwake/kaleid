import CoreMotion
import SwiftUI

enum ActiveTab: Hashable {
  case photo, camera, settings
}

struct ContentView: View {
  @State private var activeTab = ActiveTab.camera
  @StateObject private var camera = CameraModel()
  @State private var angle: Angle = .degrees(0)
  @State private var repeats = 10

  var body: some View {
    RotatedView(angle: $angle) {
      TabView(selection: $activeTab) {
        CameraKaleidoscope(repeats: repeats, camera: camera)
          .tabItem {
            Label("Camera", systemImage: "camera")
          }
          .tag(ActiveTab.camera)

        PhotoKaleidoscope(repeats: repeats, angle: angle)
          .tabItem {
            Label("Photos", systemImage: "photo")
          }
          .tag(ActiveTab.photo)

        SettingsView()
          .tabItem {
            Label("Settings", systemImage: "slider.horizontal.3")
          }
        .tag(ActiveTab.settings)
      }
      .onChange(of: activeTab, initial: true) {
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
