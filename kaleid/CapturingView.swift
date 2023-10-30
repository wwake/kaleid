import SwiftUI

struct CapturingView<Content: View>: View {
  @Binding var captured: Image
  var content: Content

  @State private var scale: Double = 1.0

  @Environment(\.displayScale) var displayScale

  init(captured: Binding<Image>, @ViewBuilder _ content: () -> Content) {
    self._captured = captured
    self.content = content()
  }

  var body: some View {
    ZStack {
      content
        .onTapGesture {
          withAnimation(.linear(duration: 1.0), completionCriteria: .removed) {
            capture(content.frame(width: 300, height: 300))
            scale = 0.5
          } completion: {
            captured = Image("1px")
            scale = 1.0
          }
        }

      captured
        .scaleEffect(scale)
        .offset(x: 500.0 - 500.0 * scale, y: 500.0 - 500.0 * scale)
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
