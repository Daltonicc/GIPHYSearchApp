//
//  APIManager.swift
//  GIPHYSearchApp
//
//  Created by 박근보 on 2022/05/02.
//

import Foundation
import Alamofire

enum GIPHYAPI {
    case getGiphyData(query: String, start: Int, display: Int)
}

extension GIPHYAPI {

    var url: URL {
        return URL(string: "api.giphy.com/v1/gifs/search")!
    }

    var parameters: [String: String] {
        switch self {
        case .getGiphyData(let query, let start, let display):
            return [
                "api_key": APIKey.apikey,
                "q": "\(query)",
                "limit": "\(display)",
                "offset": "\(start)"
            ]
        }
    }

    var headers: HTTPHeaders {
        switch self {
        default:
            return [
                "Content-Type": "application/x-www-form-urlencoded",
            ]
        }
    }
}

final class APIManager {

    static let shared = APIManager()

    private init() {}

    func getMovieData(query: String, start: Int, display: Int, completion: @escaping (Result<MovieData, MovieError>) -> Void) {

        let movieAPI: GIPHYAPI = .getGiphyData(query: query, start: start, display: display)

        AF.request(movieAPI.url, method: .get, parameters: movieAPI.parameters, headers: movieAPI.headers).validate()
            .responseDecodable(of: ResponseMovieDataDTO.self) { [weak self] response in
                switch response.result {
                case .success(let data):
                    let movieData = data.toEntity()
                    completion(.success(movieData))
                case .failure(_):
                    guard let statusCode = response.response?.statusCode else { return }
                    guard let error = self?.statusCodeCheck(statusCode: statusCode) else { return }
                    completion(.failure(error))
                }
            }
    }
