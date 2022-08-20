//
//  GIFData.swift
//  GIPHYSearchApp
//
//  Created by 박근보 on 2022/05/03.
//

import Foundation

struct GIFs {
    let item: [GIFItem]
    let pagination: Pagination
}

struct GIFItem: Hashable {
    static func == (lhs: GIFItem, rhs: GIFItem) -> Bool {
        lhs.uuid == rhs.uuid
    }

    func hash(into hasher: inout Hasher) {
        hasher.combine(uuid)
    }

    let type: String
    let id: String
    let webPageURL: String
    let title: String
    let images: GIFCategory
    let user: UserData
    let isFavorite: Bool
    let uuid = UUID()
}

struct GIFCategory {
    let original: GIFSize
    let preview: GIFSize
}

struct GIFSize {
    let height: String
    let width: String
    let size: String
    let url: String
}

struct UserData {
    let avatarURL: String
    let name: String
}

struct Pagination {
    let total: Int
    let count: Int
    let start: Int
}
