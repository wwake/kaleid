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

  func angleToX(_ angle: Angle, _ size: CGSize) -> CGFloat {
    var workingAngle = angle.radians

    while (workingAngle < -.pi) {
      workingAngle += 2 * .pi
    }

    while (workingAngle > .pi) {
      workingAngle -= 2 * .pi
    }

    return (size.width / 4) * (1 + workingAngle / .pi)
  }

  func angleToY(_ angle: Angle, _ size: CGSize, repeats: Int) -> CGFloat {
    (size.width / 4) * (1 + sin(Double(repeats) * angle.radians))
  }

  var body: some View {
    GeometryReader { geometry in
      KaleidView(count: 18) {
        Image("demo")
          .resizable()
          .offset(
            x: angleToX(angle, geometry.size),
            y: angleToY(angle, geometry.size, repeats: 64)
          )
      }
      .gesture(rotation)
    }
  }
}

#Preview {
  ContentView()
}
