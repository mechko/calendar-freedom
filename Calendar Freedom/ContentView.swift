//
//  ContentView.swift
//  Calendar Freedom
//
//  Created by Mirko Swillus on 28.01.26.
//

import SwiftUI
#if os(macOS)
import AppKit
#endif

struct ContentView: View {
    #if os(macOS)
    @Environment(\.openSettings) private var openSettings
    #endif

    @State private var roomTypes: [RoomType] = AppGroupSettings.shared.roomTypes()

    var body: some View {
        VStack(spacing: 16) {
            Text("Calendar Freedom")
                .font(.largeTitle)
                .bold()
            Text("Bringing Open Source video conferencing to your macOS calendar since 2026.")
                .font(.subheadline.italic())
                .foregroundStyle(.secondary)

            VStack(alignment: .leading, spacing: 8) {
                if roomTypes.isEmpty {
                    Text("No room types configured yet. Add one below to get started.")
                        .font(.headline)
                } else {
                    Text("Configured room types:")
                        .font(.headline)
                    ForEach(roomTypes) { roomType in
                        HStack(spacing: 4) {
                            Text("\u{2022}")
                                .foregroundStyle(.secondary)
                            Text(roomType.name.isEmpty ? "(unnamed)" : roomType.name)
                                .foregroundStyle(.secondary)
                            let base = roomType.url.trimmingCharacters(in: CharacterSet(charactersIn: "/"))
                            let fullURL: String = roomType.addRandomID
                                ? base + "/" + UUID().uuidString.replacingOccurrences(of: "-", with: "").prefix(10)
                                : base
                            if let url = URL(string: fullURL) {
                                Text("(")
                                    .foregroundStyle(.secondary)
                                Link(fullURL, destination: url)
                                Text(")")
                                    .foregroundStyle(.secondary)
                            }
                        }
                        .font(.body)
                    }
                }
            }

            Spacer()
                .frame(height: 8)

            HStack(spacing: 12) {
                Button("Manage Room Types…") {
                    #if os(macOS)
                    if #available(macOS 14.0, *) {
                        openSettings()
                    } else {
                        NSApp.sendAction(Selector(("showPreferencesWindow:")), to: nil, from: nil)
                    }
                    #endif
                }
                .keyboardShortcut(",", modifiers: [.command])
            }
        }
        .padding()
        .onAppear {
            roomTypes = AppGroupSettings.shared.roomTypes()
        }
        .onReceive(NotificationCenter.default.publisher(for: NSWindow.didBecomeKeyNotification)) { _ in
            roomTypes = AppGroupSettings.shared.roomTypes()
        }
    }
}

#Preview {
    ContentView()
}
