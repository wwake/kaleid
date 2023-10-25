import SwiftUI

struct CameraKaleidoscope: View {
  @StateObject private var camera = CameraModel()

  private let mirrors = 10

  var body: some View {
    GeometryReader { geometry in
      VStack {
        if self.camera.error != nil {
          Text(self.camera.error!)
            .foregroundStyle(.gray)
            .font(.title)
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
