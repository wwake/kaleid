import SwiftUI

struct CameraKaleidoscope: View {
  var repeats: Int

  @ObservedObject var camera: CameraModel

  var body: some View {
    VStack {
      if self.camera.error != nil {
        ErrorMessage(text: self.camera.error!)
      }

      if self.camera.image != nil {
        CapturingView {
          KaleidView(count: self.repeats) {
            Image(uiImage: self.camera.image!)
              .resizable()
              .accessibilityLabel("Kaleidoscope")
              .padding(-20.0)
          }
        }
      }
    }
  }
}
