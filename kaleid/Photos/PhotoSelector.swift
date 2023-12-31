import PhotosUI
import SwiftUI

struct PhotoSelector: View {
  @Binding var image: Image

  @State var selection: PhotosPickerItem?

  var body: some View {
    PhotosPicker(selection: $selection, matching: .images) {
      Text("Select a Photo")
    }
    .onChange(of: selection, initial: false) {
      Task {
        if let data = try? await selection?.loadTransferable(type: Data.self) {
          if let uiImage = UIImage(data: data) {
            image = Image(uiImage: uiImage) // swiftlint:disable:this accessibility_label_for_image
            return
          }
        }
      }
    }
  }
}
