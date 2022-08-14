//
//  SearchViewModel.swift
//  GIPHYSearchApp
//
//  Created by 박근보 on 2022/05/02.
//

import Foundation

protocol SearchViewModelProtocol {
    func requestGIFs(style: CategoryStatus, query: String) async
    func requestNextGIFData(style: CategoryStatus, query: String) async
}

protocol SearchViewModelOutput: AnyObject {
    func showErrorToast(_ errorMessage: String)
}

final class SearchViewModel: SearchViewModelProtocol {
    weak var outputDelegate: SearchViewModelOutput?

    let useCase: SearchUseCase

    private var total = 0
    private var start = 0
    private var display = 20

    @Published var gifs: [GIFItem] = []
    @Published var navigationTitle = "Search"
    @Published var isEmpty = true

    init(useCase: SearchUseCase) {
        self.useCase = useCase
    }

    // 검색 요청 로직
    func requestGIFs(style: CategoryStatus, query: String) async {
        start = 0
        do {
            let gifEntity = try await useCase.getGIFs(style: style, query: query, start: start, display: display)
            navigationTitle = query
            total = gifEntity.pagination.total
            gifs = gifEntity.item
            isEmpty = isGIFsEmpty()
        } catch {
            let error = error as? SearchError
            outputDelegate?.showErrorToast(error?.errorDescription ?? "")
        }
    }

    // 다음 페이지 검색 요청 로직
    func requestNextGIFData(style: CategoryStatus, query: String) async {
        start += display
        guard start + display <= total || start < total else {
            return
        }

        do {
            let gifEntity = try await useCase.getGIFs(style: style, query: query, start: start, display: display)
            appendGIF(data: gifEntity.item)
        } catch {
            let error = error as? SearchError
            outputDelegate?.showErrorToast(error?.errorDescription ?? "")
        }
    }
}

extension SearchViewModel {
    private func isGIFsEmpty() -> Bool {
        if gifs.count == 0 {
            return false
        } else {
            return true
        }
    }

    private func appendGIF(data: [GIFItem]) {
        for i in data {
            self.gifs.append(i)
        }
    }
}
