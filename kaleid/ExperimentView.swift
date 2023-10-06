import SwiftUI

struct ExperimentView: View {
  @State private var someImage: Image?

  var body: some View {
    VStack {
      if let someImage {
        someImage
          .resizable()
//          .scaledToFit()
      } else {
        Text("No image found")
      }
      
      PhotoSelector(image: $someImage)
    }
  }
}

#Preview {
    ExperimentView()
}
