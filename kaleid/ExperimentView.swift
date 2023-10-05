import SwiftUI

struct ExperimentView: View {
  @State private var someImage: Image?

  var body: some View {
    if let someImage {
      someImage
        .scaledToFit()
    }

    PhotoSelector(image: $someImage)
  }
}

#Preview {
    ExperimentView()
}
