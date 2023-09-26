import SwiftUI

struct ContentView: View {
  var body: some View {
    ZStack {
      MirroredView {
        Image("demo")
          .resizable()
          .clipShape(Pie(count: 6))
      }
      MirroredView {
        Image("demo")
          .resizable()
          .clipShape(Pie(count: 6))
      }
      .rotationEffect(.degrees(240), anchor: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
      MirroredView {
        Image("demo")
          .resizable()
          .clipShape(Pie(count: 6))
      }
      .rotationEffect(.degrees(120), anchor: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
    }
    .padding()
  }
}

#Preview {
  ContentView()
}
