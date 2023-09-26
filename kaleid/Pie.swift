import SwiftUI

struct Pie: Shape {
  let count: CGFloat
  let angle: Angle

  func path(in rect: CGRect) -> Path {
    let minDimension = min(rect.width, rect.height)

    let center = CGPoint(x: rect.midX, y: rect.midY)

    var path = Path()
    path.move(to: center)
    path.addLine(to: CGPoint(x: rect.midX, y: rect.midY + minDimension / 2.0))
    path.addArc(
      center: center,
      radius: minDimension / 2.0,
      startAngle: Angle.degrees(90),
      endAngle: .degrees(30),
      clockwise: true
    )
    path.closeSubpath()

    return path
      .applying(CGAffineTransform(scaleX: 1.0, y: -1.0))
  }
}

#Preview {
  Pie(count: 6, angle: .degrees(60))
    .stroke(Color.green)
    .offset(x: 0, y: 800)
}
