import SwiftUI

struct CameraKaleidoscope: View {
  @ObservedObject var camera: CameraModel
  
  private let mirrors = 10

  var body: some View {
    GeometryReader { geometry in
      VStack {
        if self.camera.error != nil {
          ErrorMessage(text: self.camera.error!)
        }

        if self.camera.image != nil {
          KaleidView(count: self.mirrors) {
            Image(uiImage: self.camera.image!)
              .resizable()
              .padding(-20.0)
          }
        }
      }
    }
  }
}
