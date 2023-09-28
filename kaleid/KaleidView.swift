import SwiftUI

struct KaleidView<Content: View>: View {
  let count: Int
  let content: Content

  init(count: Int, @ViewBuilder _ content: () -> Content) {
    self.count = count
    self.content = content()
  }

  var body: some View {
    let mirroredRotationAngle = 360.0 / CGFloat(count / 2)

    return ZStack {
      ForEach(0..<(count / 2), id: \.self) { index in
        MirroredView {
          content
            .clipShape(Pie(count: Int(count)))
        }
        .rotationEffect(.degrees(CGFloat(index) * mirroredRotationAngle), anchor: .center)
      }
    }
  }
}


#Preview {
  KaleidView(count: 6) {
    Image(systemName: "heart")
      .font(.largeTitle)
  }
}
