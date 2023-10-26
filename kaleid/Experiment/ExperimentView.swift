import SwiftUI

struct KaleidExperiment: View {
  var angle: Angle
  @Binding var sourceImage: Image?

  private let mirrors = 10
  private let sineRepeats = 3

  var body: some View {
    if sourceImage != nil {
      GeometryReader { geometry in
        KaleidView(count: self.mirrors) {
          sourceImage!
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
}

struct ExperimentView: View {
  var angle: Angle

  @State private var sourceImage: Image?

  @State private var renderedImage = Image(systemName: "photo")
  @Environment(\.displayScale) var displayScale

  var body: some View {
    VStack {
      KaleidExperiment(angle: angle, sourceImage: $sourceImage)
        .onTapGesture {
          capture(angle: angle, sourceImage: $sourceImage)
        }
      PhotoSelector(image: self.$sourceImage)

      renderedImage
    }
  }

  @MainActor func capture(angle: Angle, sourceImage: Binding<Image?>) {
    let renderer = ImageRenderer(content: KaleidExperiment(angle: angle, sourceImage: sourceImage)
      .frame(width: 300, height: 300))

    renderer.scale = displayScale

    if let uiImage = renderer.uiImage {
      renderedImage = Image(uiImage: uiImage)
    }
  }
}

#Preview {
  ExperimentView(angle: .degrees(0))
}