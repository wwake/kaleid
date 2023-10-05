import PhotosUI
import SwiftUI

@MainActor
struct PhotoSelector: View {
  @Binding var image: Image?

  @State var selectedPhoto: PhotosPickerItem?

  var body: some View {
    PhotosPicker(
      selection: $selectedPhoto,
      matching: .images
    ) {
      Text("Select a Photo")
    }
    .onChange(of: selectedPhoto, initial: false) { newItem, _  in
      Task {
        if let data = try? await newItem?.loadTransferable(type: Data.self) {
          if let uiImage = UIImage(data: data) {
            image = Image(uiImage: uiImage)
            return
          }
        }
      }
    }
  }
}
