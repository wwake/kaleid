import PhotosUI
import SwiftUI

struct PhotoSelector: View {
  @Binding var selectedPhoto: PhotosPickerItem?

  var body: some View {
    PhotosPicker(
      selection: $selectedPhoto,
      matching: .images
    ) {
      Text("Select a Photo")
    }
  }
}
