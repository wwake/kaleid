import CoreMotion
import PhotosUI
import SwiftUI

public struct PhotoKaleidoscope: View {
  @State private var angle: Angle = .degrees(0)

  @State private var sourceImage: Image?

  @State private var motionManager: CMMotionManager!

  private let mirrors = 10
  private let sineRepeats = 3

  var rotation: some Gesture {
    RotateGesture()
      .onChanged { value in
        self.angle = value.rotation
      }
  }

  public var body: some View {
    GeometryReader { geometry in
      VStack {
        VStack {
          KaleidView(count: self.mirrors) {
            if let sourceImage {
              sourceImage
                .resizable()
                .padding(-20.0)
                .offset(
                  x: self.angle.toXOffset(geometry.size),
                  y: self.angle.toYOffset(geometry.size, repeats: self.sineRepeats)
                )
            }
          }
          .onChange(of: sourceImage, initial: true) {
            print("sourceImage now \($0) initial \($1)")
          }
          .gesture(self.rotation)

          PhotoSelector(image: self.$sourceImage)
        }
      }
    }    
    .onAppear {
      self.motionManager = CMMotionManager()
      self.motionManager.deviceMotionUpdateInterval = TimeInterval(0.05)
      self.motionManager.startDeviceMotionUpdates(to: OperationQueue.main, withHandler: self.motionUpdateHandler)
    }
  }

  func motionUpdateHandler(_ data: CMDeviceMotion?, _ error: Error?) {
    if data == nil || error != nil { return }
    angle = .radians(data!.attitude.yaw)
  }
}
