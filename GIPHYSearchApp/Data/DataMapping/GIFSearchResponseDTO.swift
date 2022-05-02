//
//  GIFSearchResponseDTO.swift
//  GIPHYSearchApp
//
//  Created by 박근보 on 2022/05/02.
//

import Foundation

struct GIFSearchResponseDTO: Codable {
    let data: [DatumDTO]
    let pagination: PaginationDTO
}

struct DatumDTO: Codable {
    let type: String
    let id: String
    let url: String
    let title: String
    let images: ImagesDTO
    let user: UserDTO?

    enum CodingKeys: String, CodingKey {
        case type, id, url
        case title
        case images, user
    }
}

struct ImagesDTO: Codable {
    let original: ImageSizeDTO
    let previewGIF: ImageSizeDTO

    enum CodingKeys: String, CodingKey {
        case original
        case previewGIF = "preview_gif"
    }
}

struct ImageSizeDTO: Codable {
    let height, width, size: String
    let url: String

    enum CodingKeys: String, CodingKey {
        case height, width, size, url
    }
}

struct UserDTO: Codable {
    let avatarURL: String
    let username: String

    enum CodingKeys: String, CodingKey {
        case avatarURL = "avatar_url"
        case username
    }
}

struct PaginationDTO: Codable {
    let totalCount, count, offset: Int

    enum CodingKeys: String, CodingKey {
        case totalCount = "total_count"
        case count, offset
    }
}

// MARK: - To Entity

extension GIFSearchResponseDTO {
    func toEntity() -> GIFData {
        return .init(item: data.map { $0.toEntity() },
                     pagination: pagination.toEntity())
    }
}

extension DatumDTO {
    func toEntity() -> GIFItem {
        return .init(type: type,
                     id: id,
                     webPageURL: url,
                     title: title,
                     images: images.toEntity(),
                     user: user?.toEntity() ?? UserData(avatarURL: "", name: ""),
                     isFavorite: false)
    }
}

extension ImagesDTO {
    func toEntity() -> GIFCategory {
        return .init(original: original.toEntity(),
                     preview: previewGIF.toEntity())
    }
}

extension ImageSizeDTO {
    func toEntity() -> GIFSize {
        return .init(height: height,
                     width: width,
                     size: size,
                     url: url)
    }
}

extension UserDTO {
    func toEntity() -> UserData {
        return .init(avatarURL: avatarURL,
                     name: username)
    }
}

extension PaginationDTO {
    func toEntity() -> Pagination {
        return .init(total: totalCount,
                     count: count,
                     start: offset)
    }
}
