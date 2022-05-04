//
//  DetailViewModel.swift
//  GIPHYSearchApp
//
//  Created by 박근보 on 2022/05/03.
//

import Foundation

protocol DetailViewModelProtocol {
    func pressFavoriteButton(item: GIFItem?, favoriteItem: GIFFavoriteItem?, completion: () -> Void)
    func checkDatabase(item: GIFItem) -> Bool
}

final class DetailViewModel: DetailViewModelProtocol {

    private var gifFavoriteItemList: [GIFFavoriteItem] = {
        CoreDataManager.shared.fetchData(request: GIFFavoriteItem.fetchRequest())
    }()

    func pressFavoriteButton(item: GIFItem?, favoriteItem: GIFFavoriteItem?, completion: () -> Void) {
        if let item = item {
            if checkDatabase(item: item) {
                CoreDataManager.shared.deleteGIFItem(object: gifFavoriteItemList.filter { $0.id == item.id }[0])
                gifFavoriteItemList = CoreDataManager.shared.fetchData(request: GIFFavoriteItem.fetchRequest())
            } else {
                CoreDataManager.shared.saveGIFItem(item: item)
                gifFavoriteItemList = CoreDataManager.shared.fetchData(request: GIFFavoriteItem.fetchRequest())
            }
        }
        if let favoriteItem = favoriteItem {
            CoreDataManager.shared.deleteGIFItem(object: favoriteItem)
            completion()
        }
    }

    func checkDatabase(item: GIFItem) -> Bool {
        let filterValue = gifFavoriteItemList.filter { $0.id == item.id }
        if filterValue.count >= 1 {
            return true
        } else {
            return false
        }
    }
}
