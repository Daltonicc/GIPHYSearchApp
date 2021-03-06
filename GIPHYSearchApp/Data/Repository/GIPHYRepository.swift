//
//  GIPHYRepository.swift
//  GIPHYSearchApp
//
//  Created by 박근보 on 2022/05/02.
//

import Foundation
import Alamofire

final class GIPHYRepository: GIPHYRepositoryInterface {

    func getGiphyData(style: CategoryStatus, query: String, start: Int, display: Int, completion: @escaping (Result<GIFData, SearchError>) -> Void) {

        var giphyAPI: GIPHYAPI = .getGifData(query: query, start: start, display: display)

        switch style {
        case .gif:
            giphyAPI = .getGifData(query: query, start: start, display: display)
        case .sticker:
            giphyAPI = .getStickerData(query: query, start: start, display: display)
        case .text:
            giphyAPI = .getTextData(query: query, start: start, display: display)
        }

        AF.request(giphyAPI.url, method: .get, parameters: giphyAPI.parameters, headers: giphyAPI.headers).validate()
            .responseDecodable(of: GIFSearchResponseDTO.self) { response in
                switch response.result {
                case .success(let data):
                    let gifData = data.toEntity()
                    completion(.success(gifData))
                case .failure(_):
                    if let statusCode = response.response?.statusCode {
                        completion(.failure(SearchError(rawValue: statusCode) ?? .badRequest))
                    } else {
                        completion(.failure(SearchError(rawValue: 500) ?? .noNetwork))
                    }
                }
            }
    }
}
