import AVFoundation
import SwiftUI
import UIKit
import VideoToolbox

struct ExperimentView: View {
  @StateObject private var camera = CameraModel()

  var body: some View {
    VStack {
      if camera.error != nil {
        ErrorMessage(text: camera.error!)
      }

      if camera.image != nil {
        Image(uiImage: camera.image!)
          .border(Color.green)
      }
    }
  }
}

#Preview {
    ExperimentView()
}
