import SwiftUI

struct ControlsView: View {
    @Bindable var viewModel: UsersViewModel

    var body: some View {
        VStack(spacing: 12) {
            TextField("Введите ID", text: $viewModel.requestedID)
                .textFieldStyle(.roundedBorder)
                .keyboardType(.numberPad)

            HStack {
                Button("Load 1...10") {
                    viewModel.loadAll()
                }
                .buttonStyle(.borderedProminent)

                Button("Load by ID") {
                    viewModel.loadSingleFromTextField()
                }
                .buttonStyle(.bordered)

                Button("Cancel") {
                    viewModel.cancelLoading()
                }
                .buttonStyle(.bordered)
                .tint(.red)
            }
        }
    }
}
