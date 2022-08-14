//
//  GIPHYRepository.swift
//  GIPHYSearchApp
//
//  Created by 박근보 on 2022/05/02.
//

import Foundation
import Alamofire

final class GIPHYRepository: GIPHYRepositoryInterface {

    func requestGIFs(style: CategoryStatus, query: String, start: Int, display: Int) async throws -> GIFs {
        var giphyAPI: GIPHYAPI = .getGifData(query: query, start: start, display: display)

        switch style {
        case .gif:
            giphyAPI = .getGifData(query: query, start: start, display: display)
        case .sticker:
            giphyAPI = .getStickerData(query: query, start: start, display: display)
        case .text:
            giphyAPI = .getTextData(query: query, start: start, display: display)
        }

        return try await withCheckedThrowingContinuation({ continuation in
            AF.request(giphyAPI.url, method: .get, parameters: giphyAPI.parameters, headers: giphyAPI.headers).validate()
                .responseDecodable(of: GIFSearchResponseDTO.self) { response in
                    switch response.result {
                    case .success(let data):
                        continuation.resume(returning: data.toEntity())
                    case .failure(_):
                        if let statusCode = response.response?.statusCode {
                            continuation.resume(throwing: SearchError(rawValue: statusCode) ?? .badRequest)
                        } else {
                            continuation.resume(throwing: SearchError(rawValue: 500) ?? .noNetwork)
                        }
                    }
                }
        })
    }
}
