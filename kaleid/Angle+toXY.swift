import SwiftUI

extension Angle {
  func toX(_ size: CGSize) -> CGFloat {
    var workingAngle = self.radians

    while (workingAngle < -.pi) {
      workingAngle += 2 * .pi
    }

    while (workingAngle > .pi) {
      workingAngle -= 2 * .pi
    }

    return (size.width / 4) * (1 + workingAngle / .pi)
  }

  func angleToY(_ angle: Angle, _ size: CGSize, repeats: Int) -> CGFloat {
    (size.width / 4) * (1 + sin(Double(repeats) * angle.radians))
  }
}
