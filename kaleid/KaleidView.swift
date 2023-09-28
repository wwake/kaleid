import SwiftUI

struct KaleidView<Content: View>: View {
  let count: Int
  let content: Content

  init(count: Int, @ViewBuilder _ content: () -> Content) {
    self.count = count
    self.content = content()
  }

  var body: some View {
    let angle = 360.0 / CGFloat(count) * 2.0

    return ZStack {
      ForEach(0..<Int(CGFloat(count) / 2.0), id: \.self) { index in
        MirroredView {
          content
            .clipShape(Pie(count: Int(count)))
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
