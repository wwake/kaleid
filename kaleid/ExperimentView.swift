import SwiftUI

struct ExperimentView: View {
  let mirrors = 3
  let sineRepeats = 2
  @State private var angle: Angle = .zero

  var rotation: some Gesture {
    RotateGesture()
      .onChanged { value in
        angle = value.rotation
      }
  }

  var body: some View {
    GeometryReader { geometry in
      ZStack {
        Image("demo")
          .resizable()
        Pie(count: mirrors * 2)
          .offset(
            x: angle.toXOffset(geometry.size, mirrors),
            y: angle.toY(geometry.size, repeats: sineRepeats)
          )
          .stroke(Color.red)

      }
      .gesture(rotation)
    }
  }
}

#Preview {
    ExperimentView()
}
