import SwiftUI

struct CapturingView<Content: View>: View {
  @Binding var captured: Image
  var content: Content

  @Environment(\.displayScale) var displayScale

  init(captured: Binding<Image>, @ViewBuilder _ content: () -> Content) {
    self._captured = captured
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
//      print(" \(String(describing: uiImage.jpegData(compressionQuality: 0.85)))")
      captured = Image(uiImage: uiImage)
    }
  }
}
