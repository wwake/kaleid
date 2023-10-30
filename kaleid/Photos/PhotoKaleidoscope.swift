import CoreMotion
import PhotosUI
import SwiftUI

public struct PhotoKaleidoscope: View {
  var angle: Angle
  
  @State private var sourceImage: Image?
  @State private var captured: Image = Image(systemName: "photo")

  private let mirrors = 10
  private let sineRepeats = 3
  
  public var body: some View {
    VStack {
      if sourceImage == nil {
        ErrorMessage(text: "No image selected")
      } else {
        CapturingView(captured: $captured) {
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

      PhotoSelector(image: self.$sourceImage)
        .padding([.bottom], 24)
      
      captured

      Spacer()
    }
  }
}
