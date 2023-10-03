import SwiftUI


extension Angle {
  static var minX = 100000000.0
  static var maxX = -100000000.0
  static var minY = 100000000.0
  static var maxY = -100000000.0

  func toXOffset(_ size: CGSize, _ mirrors: Int) -> CGFloat {
    var workingAngle = self.radians

    while (workingAngle > 2 * .pi) {
      workingAngle -= 2 * .pi
    }

    while (workingAngle < 0) {
      workingAngle += 2 * .pi
    }

    let percent = workingAngle / (2.0 * .pi)

    let minX = -size.width / 2.0
    let maxX = 0.0 + 5.0

    let result = -0.5 * size.width * percent + 5.0

    assert(result >= minX && result <= maxX)

    return -result
  }

  func toY(_ size: CGSize, repeats: Int) -> CGFloat {
    let radius = min(size.width, size.height) / 2.0

    let percent = (1 + sin(Double(repeats) * self.radians)) / 2.0

    let centerY = size.height / 2.0 - 5.0
    let minYOffset = centerY - radius
    let maxYOffset = -size.height / 2.0 + 5.0

    let result = -(minYOffset + (maxYOffset - minYOffset) * percent)

    if percent < 0.0 || percent > 1.0 {
      print("percent out of bounds - \(percent)")
    }

    print("angle=\(self.degrees) min=\(minYOffset) max=\(maxYOffset) result = \(result)")
    return -result
  }
}
