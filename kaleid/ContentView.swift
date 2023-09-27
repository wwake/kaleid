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

  func angleToX(_ angle: Angle, _ size: CGSize) -> CGFloat {
    var workingAngle = angle.radians

    while (workingAngle < -.pi) {
      workingAngle += 2 * .pi
    }

    while (workingAngle > .pi) {
      workingAngle -= 2 * .pi
    }

    return size.width * (workingAngle / (2 * .pi)) + size.width / 2
  }

  func angleToY(_ angle: Angle, _ size: CGSize) -> CGFloat {
    size.height * sin(10 * angle.radians) / 4.0
  }

  var body: some View {
    GeometryReader { geometry in
      KaleidView(count: 6) {
        Image("demo")
          .resizable()
          .offset(
            x: angleToX(angle, geometry.size),
            y: angleToY(angle, geometry.size)
          )
      }
 //     .rotationEffect(angle)

      .gesture(moveFocus)
      .gesture(rotation)
    }
  }
}

#Preview {
  ContentView()
}
