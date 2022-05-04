//
//  FavoriteViewModel.swift
//  GIPHYSearchApp
//
//  Created by 박근보 on 2022/05/04.
//

import Foundation

protocol FavoriteViewModelProtocol {
    func fetchFavoriteGIFItemList(completion: (Bool) -> Void)
}

final class FavoriteViewModel: FavoriteViewModelProtocol {

    var gifFavoriteItemList: Observable<[GIFFavoriteItem]> = Observable([])

    func fetchFavoriteGIFItemList(completion: (Bool) -> Void) {
        gifFavoriteItemList.value = CoreDataManager.shared.fetchData(request: GIFFavoriteItem.fetchRequest())
        completion(checkEmptyList())
    }
}

extension FavoriteViewModel {

    private func checkEmptyList() -> Bool {
        if gifFavoriteItemList.value.count == 0 {
            return false
        } else {
            return true
        }
    }
}
