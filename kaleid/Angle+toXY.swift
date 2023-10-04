import SwiftUI


extension Angle {
  static var twoPi = 2.0 * Double.pi

  static var minX = 100000000.0
  static var maxX = -100000000.0
  static var minY = 100000000.0
  static var maxY = -100000000.0

  func toXOffset(_ size: CGSize) -> CGFloat {
    var workingAngle = self.radians

    while (workingAngle >= Angle.twoPi) {
      workingAngle -= Angle.twoPi
    }

    while (workingAngle < 0) {
      workingAngle += Angle.twoPi
    }

    let percent = workingAngle / Angle.twoPi

    return 0.5 * size.width * percent
  }

  func toYOffset(_ size: CGSize, repeats: Int) -> CGFloat {
    let radius = min(size.width, size.height) / 2.0

    let percent = (1 + sin(Double(repeats) * self.radians)) / 2.0

    let centerY = size.height / 2.0
    let minYOffset = centerY - radius
    let maxYOffset = -size.height / 2.0

    let result = -(minYOffset + (maxYOffset - minYOffset) * percent)

    if percent < 0.0 || percent > 1.0 {
      print("percent out of bounds - \(percent)")
    }

    return -result
  }
}
