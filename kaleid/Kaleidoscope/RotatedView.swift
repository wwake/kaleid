import CoreMotion
import SwiftUI

public struct RotatedView<Content: View>: View {
  var angle: Binding<Angle>
  let content: Content

  @State private var motionManager: CMMotionManager!

  init(angle: Binding<Angle>, @ViewBuilder _ content: () -> Content) {
    self.angle = angle
    self.content = content()
  }

  public var body: some View {
    content
      .onAppear {
        self.motionManager = CMMotionManager()
        self.motionManager.deviceMotionUpdateInterval = TimeInterval(0.05)
        self.motionManager.startDeviceMotionUpdates(to: OperationQueue.main, withHandler: self.motionUpdateHandler)
      }
  }

  func motionUpdateHandler(_ data: CMDeviceMotion?, _ error: Error?) {
    if data == nil || error != nil { return }
    angle.wrappedValue = .radians(data!.attitude.yaw)
  }
}
