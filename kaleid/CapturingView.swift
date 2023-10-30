import SwiftUI

struct CapturingView<Content: View>: View {
  @Binding var captured: Image
  var content: Content

  @State private var scale: Double = 1.0
  @State private var offset: Double = 0.0

  @Environment(\.displayScale) var displayScale

  init(captured: Binding<Image>, @ViewBuilder _ content: () -> Content) {
    self._captured = captured
    self.content = content()
  }

  var body: some View {
    ZStack {
      GeometryReader { reader in
        content
          .onTapGesture {
            capture(content.frame(width: reader.size.width, height: reader.size.width))
            withAnimation(.linear(duration: 1.0), completionCriteria: .removed) {
              scale = 0.1
              offset = reader.size.width
            } completion: {
              captured = Image("1px")
              scale = 1.0
              offset = 0.0
            }
          }
      }

      captured
        .scaleEffect(scale)
        .offset(x: offset, y: offset)
    }
  }

  @MainActor func capture(_ content: some View) {
    let renderer = ImageRenderer(content: content)

    renderer.scale = displayScale

    if let uiImage = renderer.uiImage {
//      print(" \(String(describing: uiImage.jpegData(compressionQuality: 0.85)))")
      captured = Image(uiImage: uiImage)
    }
  }
}
