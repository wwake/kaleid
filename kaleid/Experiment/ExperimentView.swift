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

struct CapturingView<Content: View>: View {
  var content: Content

  @Environment(\.displayScale) var displayScale

  init(@ViewBuilder _ content: () -> Content) {
    self.content = content()
  }

  var body: some View {
    content
      .onTapGesture {
        capture(content.frame(width: 300, height: 300))
      }
  }
  @MainActor func capture(_ content: some View) {
    let renderer = ImageRenderer(content: content)

    renderer.scale = displayScale

    if let uiImage = renderer.uiImage {
      print(" \(String(describing: uiImage.jpegData(compressionQuality: 0.85)))")
      //renderedImage = Image(uiImage: uiImage)
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
      CapturingView {
        KaleidExperiment(angle: angle, sourceImage: $sourceImage)
      }

      PhotoSelector(image: self.$sourceImage)

      renderedImage
    }
  }

  @MainActor func capture<Content: View>(angle: Angle, sourceImage: Binding<Image?>, @ViewBuilder _ content: () -> Content) {
    let renderer = ImageRenderer(content: content())

    renderer.scale = displayScale

    if let uiImage = renderer.uiImage {
      renderedImage = Image(uiImage: uiImage)
    }
  }
}

#Preview {
  ExperimentView(angle: .degrees(0))
}
