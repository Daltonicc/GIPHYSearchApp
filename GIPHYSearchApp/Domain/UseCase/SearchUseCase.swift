//
//  SearchUseCase.swift
//  GIPHYSearchApp
//
//  Created by 박근보 on 2022/05/03.
//

import Foundation

final class SearchUseCase {

    let repository: GIPHYRepositoryInterface

    init(repository: GIPHYRepositoryInterface) {
        self.repository = repository
    }

    func getGIFData(style: CategoryStatus, query: String, start: Int, display: Int, completion: @escaping (Result<GIFData, SearchError>) -> Void) {
        repository.getGiphyData(style: style, query: query, start: start, display: display, completion: completion)
    }
}
