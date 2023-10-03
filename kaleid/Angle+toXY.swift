import SwiftUI


extension Angle {
  static var minX = 100000000.0
  static var maxX = -100000000.0
  static var minY = 100000000.0
  static var maxY = -100000000.0

  func toX(_ size: CGSize, _ mirrors: Int) -> CGFloat {
    var workingAngle = self.radians

    while (workingAngle > 2 * .pi) {
      workingAngle -= 2 * .pi
    }

    while (workingAngle < 0) {
      workingAngle += 2 * .pi
    }

    let percent = workingAngle / (2.0 * .pi)

    return percent * size.width * (Double(mirrors) - 2) / Double(mirrors)
  }

//  func toX(_ size: CGSize, _ mirrors: Int) -> CGFloat {
//    var workingAngle = self.radians
//
//    while (workingAngle < -.pi) {
//      workingAngle += 2 * .pi
//    }
//
//    while (workingAngle > .pi) {
//      workingAngle -= 2 * .pi
//    }
//
//    return (size.width / 4) * (1 + workingAngle / .pi)
//  }


//  func toY(_ size: CGSize, repeats: Int) -> CGFloat {
//    let scaledSine = (1 + sin(Double(repeats) * self.radians)) / 2.0
//    let result = size.height / 2.0 + (size.height / 2.0) * scaledSine
//    Angle.minY = min(result, Angle.minY)
//    Angle.maxY = max(result, Angle.maxY)
//    print("a=\(self.degrees) min=\(Angle.minY.rounded()) max=\(Angle.maxY.rounded()) -> \(result.rounded())")
//
//    return result
//  }

  func toY(_ size: CGSize, repeats: Int) -> CGFloat {
    (size.width / 4) * (1 + sin(Double(repeats) * self.radians))
  }
}
