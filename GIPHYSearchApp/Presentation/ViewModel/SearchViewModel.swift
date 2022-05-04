//
//  SearchViewModel.swift
//  GIPHYSearchApp
//
//  Created by 박근보 on 2022/05/02.
//

import Foundation

protocol SearchViewModelProtocol {
    func requestGIFData(style: CategoryStatus, query: String, completion: @escaping (Bool, String?) -> Void)
    func requestNextGIFData(style: CategoryStatus, query: String, completion: @escaping (String?) -> Void)
}

final class SearchViewModel: SearchViewModelProtocol {

    let useCase: SearchUseCase

    private var total = 0
    private var start = 0
    private var display = 20

    var navigationTitle: Observable<String> = Observable("Search")
    var gifData: Observable<[GIFItem]> = Observable([])

    init(useCase: SearchUseCase) {
        self.useCase = useCase
    }

    // 검색 요청 로직
    func requestGIFData(style: CategoryStatus, query: String, completion: @escaping (Bool, String?) -> Void) {
        start = 0
        useCase.getGIFData(style: style, query: query, start: start, display: display) { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let data):
                self.navigationTitle.value = query
                self.total = data.pagination.total
                self.gifData.value = data.item
                completion(self.noResultCheck(), nil)
            case .failure(let error):
                completion(false, error.errorDescription)
            }
        }
    }

    // 다음 페이지 검색 요청 로직
    func requestNextGIFData(style: CategoryStatus, query: String, completion: @escaping (String?) -> Void) {
        start += display
        guard start + display <= total || start < total else { return }
        useCase.getGIFData(style: style, query: query, start: start, display: display) { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let data):
                self.appendData(data: data.item)
                completion(nil)
            case .failure(let error):
                completion(error.errorDescription)
            }
        }
    }
}

extension SearchViewModel {

    private func noResultCheck() -> Bool {
        if gifData.value.count == 0 {
            return false
        } else {
            return true
        }
    }

    private func appendData(data: [GIFItem]) {
        for i in data {
            self.gifData.value.append(i)
        }
    }
}
