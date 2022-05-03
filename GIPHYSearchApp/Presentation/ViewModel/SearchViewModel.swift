//
//  SearchViewModel.swift
//  GIPHYSearchApp
//
//  Created by 박근보 on 2022/05/02.
//

import Foundation

protocol SearchViewModelProtocol {
    func requestGIFData(style: CategoryStatus, query: String, completion: @escaping (Bool, String?) -> Void)
}

final class SearchViewModel: SearchViewModelProtocol {

    let useCase: SearchUseCase

    private var total = 0
    private var start = 0
    private var display = 20

    var gifData: Observable<[GIFItem]> = Observable([])
    var heightList: [Int] = []

    init(useCase: SearchUseCase) {
        self.useCase = useCase
    }

    func requestGIFData(style: CategoryStatus, query: String, completion: @escaping (Bool, String?) -> Void) {
        start = 0
        useCase.getGIFData(style: style, query: query, start: start, display: display) { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let data):
                self.heightList.removeAll()
                self.total = data.pagination.total
                self.gifData.value = data.item
                self.getImageHeightList()
                completion(self.noResultCheck(), nil)
            case .failure(let error):
                completion(false, error.errorDescription)
            }
        }
    }

    func requestNextGIFData(style: CategoryStatus, query: String, completion: @escaping (String?) -> Void) {
        start += display
        guard start + display <= total || start < total else { return }
        useCase.getGIFData(style: style, query: query, start: start, display: display) { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let data):
                self.appendData(data: data.item)
                self.getImageHeightList()
                completion(nil)
            case .failure(let error):
                completion(error.errorDescription)
            }
        }
    }
}

extension SearchViewModel {

    private func getImageHeightList() {
        for i in gifData.value {
            heightList.append(Int(i.images.original.height) ?? 0)
        }
    }

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
