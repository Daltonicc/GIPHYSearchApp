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

    func getGIFs(style: CategoryStatus, query: String, start: Int, display: Int) async throws -> GIFs {
        do {
            return try await repository.requestGIFs(style: style, query: query, start: start, display: display)
        } catch {
            throw error
        }
    }
}
