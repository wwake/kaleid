import SwiftUI

extension Angle {
  static var twoPi = 2.0 * Double.pi

  var toPositiveRadians: Double {
    var workingAngle = self.radians

    while workingAngle >= Angle.twoPi {
      workingAngle -= Angle.twoPi
    }

    while workingAngle < 0 {
      workingAngle += Angle.twoPi
    }

    return workingAngle
  }

  func toXOffset(_ size: CGSize) -> CGFloat {
    let percent = self.toPositiveRadians / Angle.twoPi

    return 0.5 * size.width * percent
  }

  func toYOffset(_ size: CGSize, repeats: Int) -> CGFloat {
    let percent = (1 + sin(Double(repeats) * self.radians)) / 2.0

    let halfHeight = size.height / 2.0
    let radius = min(size.width / 2.0, halfHeight)

    return (size.height - radius) * percent - halfHeight
  }
}
