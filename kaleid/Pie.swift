import SwiftUI

struct Pie: Shape {
  let count: CGFloat

  func path(in rect: CGRect) -> Path {
    print("Pie: \(rect)")
    let minDimension = min(rect.width, rect.height)

    let center = CGPoint(x: rect.midX, y: rect.midY)

    let angle = 2 * .pi / count

    var path = Path()
    path.move(to: center)
    path.addLine(to: CGPoint(x: rect.midX, y: rect.midY + minDimension / 2.0))
    path.addArc(
      center: center,
      radius: minDimension / 2.0,
      startAngle: Angle.degrees(90),
      endAngle: .degrees(90) - .radians(angle),
      clockwise: true
    )
    path.closeSubpath()

    return path
      .applying(CGAffineTransform(scaleX: 1.0, y: -1.0))
      .applying(CGAffineTransform(translationX: 0.0, y: rect.height))
  }
}

#Preview {
  Pie(count: 6)
    .stroke(Color.green)
}
