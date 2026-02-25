//
//  VirtualConferenceProvider.swift
//  CalendarFreedomExtension
//
//  Created by Mirko Swillus on 28.01.26.
//

import EventKit
import Foundation

class VirtualConferenceProvider: EKVirtualConferenceProvider {

    override func fetchAvailableRoomTypes() async throws -> [EKVirtualConferenceRoomTypeDescriptor] {
        let roomTypes = AppGroupSettings.shared.roomTypes()
        return roomTypes.map { roomType in
            EKVirtualConferenceRoomTypeDescriptor(title: roomType.name, identifier: roomType.id.uuidString)
        }
    }

    override func fetchVirtualConference(identifier: EKVirtualConferenceRoomTypeIdentifier) async throws -> EKVirtualConferenceDescriptor {
        let roomTypes = AppGroupSettings.shared.roomTypes()
        guard let roomType = roomTypes.first(where: { $0.id.uuidString == identifier }) else {
            NSLog("[VirtualConferenceProvider] Error: No room type found for identifier: %@", identifier)
            throw NSError(domain: "VirtualConferenceProvider", code: 1, userInfo: [NSLocalizedDescriptionKey: "Unknown room type"])
        }

        let base = roomType.url.trimmingCharacters(in: CharacterSet(charactersIn: "/"))
        let finalURLString: String
        if roomType.addRandomID {
            let slug = UUID().uuidString.replacingOccurrences(of: "-", with: "").prefix(10)
            finalURLString = "\(base)/\(slug)"
        } else {
            finalURLString = base
        }

        NSLog("[VirtualConferenceProvider] Using URL: %@", finalURLString)
        guard let url = URL(string: finalURLString) else {
            NSLog("[VirtualConferenceProvider] Error: Invalid URL: %@", finalURLString)
            throw NSError(domain: "VirtualConferenceProvider", code: 2, userInfo: [NSLocalizedDescriptionKey: "Invalid URL"])
        }

        let urlDescriptor = EKVirtualConferenceURLDescriptor(title: nil, url: url)
        let descriptor = EKVirtualConferenceDescriptor(title: roomType.name, urlDescriptors: [urlDescriptor], conferenceDetails: nil)
        return descriptor
    }
}
