import SwiftUI

public struct ErrorMessage: View {
  var text: String?

  public var body: some View {
    VStack {
      Spacer()
      HStack {
        Spacer()
        Text(text ?? "")
          .foregroundStyle(.gray)
          .font(.title)
        Spacer()
      }
      Spacer()
    }
  }
}
