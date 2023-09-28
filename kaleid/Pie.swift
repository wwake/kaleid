import SwiftUI

struct Pie: Shape {
  let count: Int

  func path(in rect: CGRect) -> Path {
    let minDimension = min(rect.width, rect.height)
    let center = CGPoint(x: rect.midX, y: rect.midY)

    let angle = 2 * .pi / CGFloat(count)

    var path = Path()
    path.move(to: center)
    path.addLine(to: CGPoint(x: rect.midX, y: rect.midY - minDimension / 2.0))
    path.addArc(
      center: center,
      radius: minDimension / 2.0,
      startAngle: Angle.degrees(270),
      endAngle: .degrees(270) + .radians(angle),
      clockwise: false
    )
    path.closeSubpath()

    return path
  }
}

#Preview {
  Pie(count: 6)
    .stroke(Color.green)
}
