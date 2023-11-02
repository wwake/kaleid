import SwiftUI

struct SettingsView: View {
  @Binding var repeats: Int

  var repeatsEditing: Binding<Double> = .constant(0)

  init(repeats: Binding<Int>) {
    self._repeats = repeats

    defer {
      repeatsEditing = Binding(
        get: { Double(repeats.wrappedValue) },
        set: { repeats.wrappedValue = Int($0) }
      )
    }
  }

  var body: some View {
    NavigationStack {
      Form {
        Section {
          HStack {
            Text("Repeats: \(repeats)")

            Slider(
              value: repeatsEditing,
              in: 3...20,
              step: 1
            ) {
              Text("Repeats: \(repeats)")
            } onEditingChanged: { _ in
            }
          }
        } header: {
          Text("")
        }
      }
      .navigationTitle("Settings")
      .padding()
    }
  }
}

#Preview {
  SettingsView(repeats: .constant(7))
}
