import Foundation

enum AppSettings {
    static let roomTypesKey = "RoomTypes"
    static let maxRoomTypes = 5

    // App Group identifier used to share settings between the app and the extension.
    static let appGroupIdentifier = "group.eu.swillus.CalendarFreedom"

    static let defaultRoomTypes: [RoomType] = [
        RoomType(id: UUID(uuidString: "00000000-0000-0000-0000-000000000001")!,
                 name: "Jitsi Meeting",
                 url: "https://meet.jit.si",
                 addRandomID: true)
    ]
}
