import SwiftUI

struct MirroredView<Content: View>: View {
  let content: Content

  init(@ViewBuilder _ content: () -> Content) {
    self.content = content()
  }

  var body: some View {
    ZStack {
      content

      content
        .scaleEffect(x: -1)
    }
  }
}

#Preview {
  MirroredView {
    Image("demo")
      .resizable()
      .clipShape(Pie(count: 2))
  }
}
