import SwiftUI

struct KaleidView<Content: View>: View {
  let count: CGFloat
  let content: Content

  init(count: CGFloat, @ViewBuilder _ content: () -> Content) {
    self.count = count
    self.content = content()
  }

  var body: some View {
    let angle = 360.0 / count * 2.0

    return ZStack {
      ForEach(0..<Int(count / 2.0), id: \.self) { index in
        MirroredView {
          content
            .clipShape(Pie(count: count))
        }
        .rotationEffect(.degrees(CGFloat(index) * angle), anchor: .center)
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