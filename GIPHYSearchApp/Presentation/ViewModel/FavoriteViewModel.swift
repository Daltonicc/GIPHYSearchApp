//
//  FavoriteViewModel.swift
//  GIPHYSearchApp
//
//  Created by 박근보 on 2022/05/04.
//

import Foundation

protocol FavoriteViewModelProtocol {
    func fetchFavoriteGIFItemList()
}

final class FavoriteViewModel: FavoriteViewModelProtocol {

    var gifFavoriteItemList: Observable<[GIFFavoriteItem]> = Observable([])

    func fetchFavoriteGIFItemList() {
        gifFavoriteItemList.value = CoreDataManager.shared.fetchData(request: GIFFavoriteItem.fetchRequest())
    }
}
