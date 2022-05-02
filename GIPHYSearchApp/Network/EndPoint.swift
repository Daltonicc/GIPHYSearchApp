//
//  APIManager.swift
//  GIPHYSearchApp
//
//  Created by 박근보 on 2022/05/02.
//

import Foundation
import Alamofire

enum GIPHYAPI {
    case getGifData(query: String, start: Int, display: Int)
    case getStickerData(query: String, start: Int, display: Int)
    case getTextData(query: String, start: Int, display: Int)
}

extension GIPHYAPI {

    var url: URL {
        switch self {
        case .getGifData:
            return URL(string: "api.giphy.com/v1/gifs/search")!
        case .getStickerData:
            return URL(string: "api.giphy.com/v1/stickers/search")!
        case .getTextData:
            return URL(string: "api.giphy.com/v1/text/search")!
        }

    }

    var parameters: [String: String] {
        switch self {
        case .getGifData(let query, let start, let display):
            return getParameter(query: query, start: start, display: display)
        case .getStickerData(let query, let start, let display):
            return getParameter(query: query, start: start, display: display)
        case .getTextData(let query, let start, let display):
            return getParameter(query: query, start: start, display: display)
        }
    }

    var headers: HTTPHeaders {
        switch self {
        default:
            return [
                "Content-Type": "application/x-www-form-urlencoded"
            ]
        }
    }

    private func getParameter(query: String, start: Int, display: Int) -> [String: String] {
        return [
            "api_key": APIKey.apikey,
            "q": query,
            "limit": "\(display)",
            "offset": "\(start)"
        ]
    }
}
