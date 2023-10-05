import PhotosUI
import SwiftUI

struct PhotoSelector: View {
  @Binding var photoData: Data?

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
          photoData = data
        }
      }
    }
  }
}
