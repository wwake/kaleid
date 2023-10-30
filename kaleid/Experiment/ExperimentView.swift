import SwiftUI

struct KaleidExperiment: View {
  var angle: Angle
  @Binding var sourceImage: Image

  private let mirrors = 10
  private let sineRepeats = 3

  var body: some View {
    GeometryReader { geometry in
      KaleidView(count: self.mirrors) {
        sourceImage
          .resizable()
          .padding(-20.0)
          .offset(
            x: self.angle.toXOffset(geometry.size),
            y: self.angle.toYOffset(geometry.size, repeats: self.sineRepeats)
          )
      }
    }
  }
}

struct ExperimentView: View {
  var angle: Angle

  @State private var sourceImage = Image("demo")

  @State private var renderedImage = Image(systemName: "photo")
  
  @Environment(\.displayScale) var displayScale

  var body: some View {
    VStack {
      CapturingView(captured: $renderedImage) {
        KaleidExperiment(angle: angle, sourceImage: $sourceImage)
      }

      PhotoSelector(image: self.$sourceImage)

      renderedImage
    }
  }
}

#Preview {
  ExperimentView(angle: .degrees(0))
}
