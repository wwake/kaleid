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
        if let sourceImage {
          KaleidView(count: self.mirrors) {
            sourceImage
              .resizable()
              .padding(-20.0)
              .offset(
                x: self.angle.toXOffset(geometry.size),
                y: self.angle.toYOffset(geometry.size, repeats: self.sineRepeats)
              )
          }
          .gesture(self.rotation)
        } else {
          VStack {
            Spacer()
            HStack {
              Spacer()
              Text("No image selected")
                .foregroundStyle(.gray)
                .font(.title)
              Spacer()
            }
            Spacer()
          }
        }

        PhotoSelector(image: self.$sourceImage)
        Spacer()
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
