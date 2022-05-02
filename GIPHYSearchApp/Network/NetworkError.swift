//
//  NetworkError.swift
//  GIPHYSearchApp
//
//  Created by 박근보 on 2022/05/02.
//

import Foundation

enum SearchError: Int, Error {
    case badRequest = 400
    case forbidden = 403
    case notFoundData = 404
    case tooLongQuery = 414
    case tooManyRequest = 429
}

extension SearchError {
    private var errorDescription: String {
        switch self {
        case .badRequest: return "잘못된 요청입니다"
        case .forbidden: return "권한이 없습니다"
        case .notFoundData: return "데이터를 찾을 수 없습니다"
        case .tooLongQuery: return "50글자 이하로 작성해주세요"
        case .tooManyRequest: return "잠시 후 다시 시도해주세요"
        }
    }
}
