import SwiftUI

struct KaleidView<Content: View>: View {
  let count: CGFloat
  let content: Content

  init(count: CGFloat, @ViewBuilder _ content: () -> Content) {
    self.count = count
    self.content = content()
  }

  var body: some View {
    ZStack {
      MirroredView {
        content
          .clipShape(Pie(count: count))
      }

      MirroredView {
        content
          .clipShape(Pie(count: count))
      }
      .rotationEffect(.degrees(360.0 / count * 2.0), anchor: .center)

      MirroredView {
        content
          .clipShape(Pie(count: count))
      }
      .rotationEffect(.degrees(360.0 / count * 2.0 * 2.0), anchor: .center)
    }
  }
}

struct ContentView: View {
  let xOffset = CGFloat(75)
  let yOffset = CGFloat(-20)

  var body: some View {
    KaleidView(count: 6) {
      Image("demo")
        .resizable()
        .offset(x: xOffset, y: yOffset)
    }
    .padding()
  }
}

#Preview {
  ContentView()
}
