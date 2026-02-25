import Foundation

struct RoomType: Codable, Identifiable, Equatable {
    var id: UUID
    var name: String
    var url: String
    var addRandomID: Bool
}
