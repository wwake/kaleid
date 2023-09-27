import SwiftUI

struct ContentView: View {
  let xOffset = CGFloat(100)
  let yOffset = CGFloat(-20)

  var body: some View {
    KaleidView(count: 36) {
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
