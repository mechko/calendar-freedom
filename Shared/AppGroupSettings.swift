//
//  AppGroupSettings.swift
//  Calendar Freedom
//
//  Created by Mirko Swillus on 28.01.26.
//

import Foundation

final class AppGroupSettings {
    static let shared = AppGroupSettings()
    private init() {}

    private var defaults: UserDefaults {
        if let shared = UserDefaults(suiteName: AppSettings.appGroupIdentifier) {
            return shared
        } else {
            NSLog("[AppGroupSettings] Warning: Could not create UserDefaults suite for '\(AppSettings.appGroupIdentifier)'. Falling back to .standard. Ensure App Group is enabled for all relevant targets.")
            return .standard
        }
    }

    func setRoomTypes(_ roomTypes: [RoomType]) {
        if let data = try? JSONEncoder().encode(roomTypes) {
            defaults.set(data, forKey: AppSettings.roomTypesKey)
        }
    }

    func roomTypes() -> [RoomType] {
        if let data = defaults.data(forKey: AppSettings.roomTypesKey),
           let decoded = try? JSONDecoder().decode([RoomType].self, from: data) {
            return decoded
        }
        return AppSettings.defaultRoomTypes
    }
}
