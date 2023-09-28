import SwiftUI

struct ContentView: View {
  @State private var location: CGPoint = CGPoint(x: 100, y: -20)
  @State private var angle: Angle = .zero

  var rotation: some Gesture {
    RotateGesture()
      .onChanged { value in
        angle = value.rotation
      }
  }

  var body: some View {
    GeometryReader { geometry in
      VStack {
        TabView {
          VStack {
            KaleidView(count: 3) {
              Image("demo")
                .resizable()
                .offset(
                  x: angle.toX(geometry.size),
                  y: angle.toY(geometry.size, repeats: 10)
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
  }
}

#Preview {
  ContentView()
}
