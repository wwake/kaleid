import Photos
import SwiftUI

struct CapturingView<Content: View>: View {
  var content: Content

  @State private var captured = Image("1px")

  @State private var scale: Double = 1.0
  @State private var offset: Double = 0.0

  @Environment(\.displayScale) var displayScale

  init(@ViewBuilder _ content: () -> Content) {
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
//      let options = PHAssetResourceRequestOptions()
//      options.originalFilename = "Captured from kaleid"

      UIImageWriteToSavedPhotosAlbum(uiImage, nil, nil, nil)
//      UIImageWriteToSavedPhotosAlbum(image, self, #selector(image(_:didFinishSavingWithError:contextInfo:)), nil)

      captured = Image(uiImage: uiImage)
    }
  }
}
