import CoreMotion
import PhotosUI
import SwiftUI

public struct PhotoKaleidoscope2: View {
  @State private var angle: Angle = .degrees(0)
  @State private var sourceImage: Image?

  private let mirrors = 10
  private let sineRepeats = 3

  public var body: some View {
    GeometryReader { geometry in
      VStack {
        if sourceImage == nil {
          ErrorMessage(text: "No image selected")
        } else {
          RotatedView(angle: $angle) {
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
          .onTapGesture {
            print("take a photo")
          }
        }

        PhotoSelector(image: self.$sourceImage)
          .padding([.bottom], 24)

        Spacer()
      }
    }
  }
}
