import AVFoundation
import Photos
import SwiftUI

struct CapturingView<Content: View>: View {
  var content: Content

  @State private var captured = Image("1px")

  @State private var scale: Double = 1.0
  @State private var offset: Double = 0.0

  @Environment(\.displayScale) var displayScale

  @State private var showSaveMessage = false
  @State private var saveMessage = ""

  let shutterSound: SystemSoundID = 1108

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
    .alert(saveMessage, isPresented: $showSaveMessage) {
      Button("OK", role: .cancel) { }
    }
  }

  @MainActor func capture(_ content: some View) {
    let renderer = ImageRenderer(content: content)

    renderer.scale = displayScale

    if let uiImage = renderer.uiImage {
      CaptureImage($showSaveMessage, $saveMessage).write(uiImage)
      AudioServicesPlaySystemSound(shutterSound)
      captured = Image(uiImage: uiImage)
    }
  }
}

class CaptureImage: NSObject {
  @Binding var showSavedMessage: Bool
  @Binding var savedMessage: String

  init(_ showSavedMessage: Binding<Bool>, _ savedMessage: Binding<String>) {
    self._showSavedMessage = showSavedMessage
    self._savedMessage = savedMessage
  }

  func write(_ image: UIImage) {
    UIImageWriteToSavedPhotosAlbum(image, self, #selector(doneWritingPhoto), nil)
  }

  @objc func doneWritingPhoto(_ image: UIImage, didFinishSavingWithError error: Error?, contextInfo: UnsafeRawPointer) {
    if let error = error {
      DispatchQueue.main.async { [self] in
        savedMessage = "When saving image: \(error.localizedDescription)"
        showSavedMessage = true
      }
    }
  }
}
