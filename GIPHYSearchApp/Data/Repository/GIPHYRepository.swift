//
//  GIPHYRepository.swift
//  GIPHYSearchApp
//
//  Created by 박근보 on 2022/05/02.
//

import Foundation
import Alamofire

final class GIPHYRepository {

    func getGiphyData(query: String, start: Int, display: Int, completion: @escaping (Result<GIFData, SearchError>) -> Void) {

        let giphyAPI: GIPHYAPI = .getGifData(query: query, start: start, display: display)

        AF.request(giphyAPI.url, method: .get, parameters: giphyAPI.parameters, headers: giphyAPI.headers).validate()
            .responseDecodable(of: GIFSearchResponseDTO.self) { response in
                switch response.result {
                case .success(let data):
                    let gifData = data.toEntity()
                    completion(.success(gifData))
                case .failure(_):
                    guard let statusCode = response.response?.statusCode else { return }
                    completion(.failure(SearchError(rawValue: statusCode) ?? .badRequest))
                }
            }
    }
}
