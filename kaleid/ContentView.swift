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

  var moveFocus: some Gesture {
    DragGesture()
      .onChanged { value in
        self.location = CGPoint(
          x: value.location.x / 2.0,
          y: value.location.y / 4.0
        )
      }
  }

  var body: some View {
    GeometryReader {geometry in

      KaleidView(count: 6) {
        Image("demo")
          .resizable()
          .offset(x: location.x, y: location.y)
      }
      .rotationEffect(angle)

      .gesture(moveFocus)
      .gesture(rotation)
    }
  }
}

#Preview {
  ContentView()
}
