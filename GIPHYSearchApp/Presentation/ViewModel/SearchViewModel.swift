//
//  SearchViewModel.swift
//  GIPHYSearchApp
//
//  Created by 박근보 on 2022/05/02.
//

import Foundation

protocol SearchViewModelProtocol {

    // Input
    func requestGIFData(query: String, completion: @escaping (String?) -> Void)

    // Output
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

    func requestGIFData(query: String, completion: @escaping (String?) -> Void) {

        useCase.getGIFData(query: query, start: start, display: display) { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let data):
                self.total = data.pagination.total
                self.gifData.value = data.item
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
}
