import SwiftUI

struct ContentView: View {
  var body: some View {
    ZStack {
      Image("demo")
        .resizable()
        .scaledToFit()
        .scaleEffect(x: 1.5, y: 1.5)
        .clipShape(Circle())
        .offset(x: -180, y: -150)
        .clipShape(Pie(count: 0, angle: .degrees(60)))
//      Image("demo")
//        .resizable()
//        .scaledToFit()
//    //    .scaleEffect(x: 1.5, y: 1.5)
////        .clipShape(Circle())
//        .offset(x: 150, y: 100)
////        .clipShape(Pie(count: 0, angle: .degrees(60)))
//        .scaleEffect(x: -1, y: -1)

//      Pie(count: 0, angle: .degrees(60))
////       // .intersection(Image("logo.png")
//        .fill(.blue)
//      Pie(count: 1, angle: .degrees(60))
//        .fill(.red)
//      Pie(count: 2, angle: .degrees(60))
//        .fill(.blue)
//      Pie(count: 3, angle: .degrees(60))
//        .fill(.red)
//      Pie(count: 4, angle: .degrees(60))
//        .fill(.blue)
//      Pie(count: 5, angle: .degrees(60))
//        .fill(.red)
    }
    .offset(x: 170, y: 300)
    .padding()
  }
}

#Preview {
  ContentView()
}
