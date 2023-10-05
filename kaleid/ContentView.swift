import SwiftUI

struct ContentView: View {
  var body: some View {
    TabView {
      PhotoKaleidoscope()
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
  }
}

#Preview {
  ContentView()
}
