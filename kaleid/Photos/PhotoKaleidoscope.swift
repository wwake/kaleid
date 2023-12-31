import CoreMotion
import PhotosUI
import SwiftUI

public struct PhotoKaleidoscope: View {
  var repeats: Int
  var angle: Angle

  @State private var sourceImage = Image(decorative: "demo")

  private let sineRepeats = 3

  public var body: some View {
    VStack {
      CapturingView {
        GeometryReader { geometry in
          KaleidView(count: self.repeats) {
            sourceImage
              .resizable()
              .padding(-20.0)
              .offset(
                x: self.angle.toXOffset(geometry.size),
                y: self.angle.toYOffset(geometry.size, repeats: self.sineRepeats)
              )
          }
        }
      }

      PhotoSelector(image: self.$sourceImage)
        .padding([.bottom], 24)

      Spacer()
    }
  }
}
