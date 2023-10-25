import SwiftUI

enum ActiveTab: Hashable {
  case photo, camera, experiment
}

struct ContentView: View {
  @State private var activeTab = ActiveTab.photo

  var body: some View {
    TabView(selection: $activeTab) {
      PhotoKaleidoscope()
      .tabItem {
        Label("Photos", systemImage: "photo")
      }
      .tag(ActiveTab.photo)

      CameraKaleidoscope()
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
      print(activeTab)
    }
  }
}

#Preview {
  ContentView()
}
