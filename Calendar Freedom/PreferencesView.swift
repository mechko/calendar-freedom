import SwiftUI

struct PreferencesView: View {
    @State private var roomTypes: [RoomType] = AppGroupSettings.shared.roomTypes()

    private func isValidURL(_ string: String) -> Bool {
        guard let url = URL(string: string),
              let scheme = url.scheme,
              !scheme.isEmpty,
              url.host() != nil else {
            return false
        }
        return true
    }

    private func isValid(_ roomType: RoomType) -> Bool {
        !roomType.name.trimmingCharacters(in: .whitespaces).isEmpty
            && isValidURL(roomType.url)
    }

    var body: some View {
        ScrollView {
        VStack(alignment: .leading, spacing: 12) {
            Text("Video Conferencing Rooms")
                .font(.title2)
                .bold()

            Text("Configure up to \(AppSettings.maxRoomTypes) room types. Each one appears as an option in Calendar's video call picker. Room types with an empty name or invalid URL will not be available in Calendar.")
                .font(.footnote)
                .foregroundStyle(.secondary)
                .fixedSize(horizontal: false, vertical: true)

            Text("Jitsi supports creating individual rooms per meeting — enable \"Add Random Room ID\" to generate a unique link for each event. BigBlueButton and OpenTalk require a personal meeting room with a fixed URL, so leave the random ID option unchecked and enter your room's full URL directly.")
                .font(.footnote)
                .foregroundStyle(.secondary)
                .fixedSize(horizontal: false, vertical: true)

            Grid(alignment: .leading, verticalSpacing: 0) {
                GridRow {
                    Text("Name")
                    Text("URL")
                    Text("Add Random Room ID")
                    Text("")
                }
                .font(.caption)
                .foregroundStyle(.secondary)

                Divider()
                    .gridCellColumns(4)

                ForEach($roomTypes) { $roomType in
                    GridRow {
                        TextField("", text: $roomType.name)
                            .textFieldStyle(.roundedBorder)
                            .frame(minWidth: 140)
                            .overlay(
                                RoundedRectangle(cornerRadius: 5)
                                    .stroke(roomType.name.trimmingCharacters(in: .whitespaces).isEmpty ? .red.opacity(0.6) : .clear, lineWidth: 1)
                            )

                        TextField("", text: $roomType.url)
                            .textFieldStyle(.roundedBorder)
                            .disableAutocorrection(true)
                            .frame(minWidth: 200)
                            .overlay(
                                RoundedRectangle(cornerRadius: 5)
                                    .stroke(isValidURL(roomType.url) ? .clear : .red.opacity(0.6), lineWidth: 1)
                            )

                        Toggle("", isOn: $roomType.addRandomID)
                            .labelsHidden()
                            .frame(maxWidth: .infinity)

                        Button(role: .destructive) {
                            withAnimation {
                                roomTypes.removeAll { $0.id == roomType.id }
                            }
                        } label: {
                            Image(systemName: "trash")
                        }
                        .buttonStyle(.borderless)
                    }
                    .padding(.vertical, 4)
                }
            }

            Button("Add Room Type") {
                withAnimation {
                    let newRoom = RoomType(id: UUID(), name: "", url: "https://", addRandomID: false)
                    roomTypes.append(newRoom)
                }
            }
            .disabled(roomTypes.count >= AppSettings.maxRoomTypes)
        }
        .padding()
        }
        .frame(minWidth: 560, minHeight: 300)
        .onChange(of: roomTypes) { _, newValue in
            AppGroupSettings.shared.setRoomTypes(newValue.filter { isValid($0) })
        }
        .navigationTitle("Preferences")
    }
}

#Preview {
    PreferencesView()
}
