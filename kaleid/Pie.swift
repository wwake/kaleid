import SwiftUI

struct Pie: Shape {
  let count: Int

  func path(in rect: CGRect) -> Path {
    let radius = min(rect.width, rect.height) / 2.0
    let center = CGPoint(x: rect.midX, y: rect.midY)

    let angle = 2 * .pi / CGFloat(count)

    var path = Path()
    path.move(to: center)
    path.addLine(to: CGPoint(x: rect.midX, y: rect.midY - radius))
    path.addArc(
      center: center,
      radius: radius,
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
