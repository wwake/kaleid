import SwiftUI

struct KaleidView<Content: View>: View {
  let count: Int
  let content: Content

  init(count: Int, @ViewBuilder _ content: () -> Content) {
    self.count = count
    self.content = content()
  }

  var body: some View {
    let mirroredRotationAngle = 360.0 / CGFloat(count)

    return ZStack {
      ForEach(0..<count, id: \.self) { index in
        MirroredView {
          content
            .clipShape(Pie(count: 2 * count))
        }
        .rotationEffect(.degrees(CGFloat(index) * mirroredRotationAngle), anchor: .center)
      }
    }
  }
}


#Preview {
  KaleidView(count: 3) {
    Image(systemName: "heart")
      .font(.largeTitle)
  }
}
