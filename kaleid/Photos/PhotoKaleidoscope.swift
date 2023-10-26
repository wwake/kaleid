import CoreMotion
import PhotosUI
import SwiftUI

public struct PhotoKaleidoscope: View {
  var angle: Angle
  
  @State private var sourceImage: Image?
  
  private let mirrors = 10
  private let sineRepeats = 3
  
  public var body: some View {
    VStack {
      if sourceImage == nil {
        ErrorMessage(text: "No image selected")
      } else {
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
