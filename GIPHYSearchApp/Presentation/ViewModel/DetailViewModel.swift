//
//  DetailViewModel.swift
//  GIPHYSearchApp
//
//  Created by 박근보 on 2022/05/03.
//

import Foundation

protocol DetailViewModelProtocol {
    func pressFavoriteButton(item: GIFItem)
}

final class DetailViewModel: DetailViewModelProtocol {

    private var gifFavoriteItemList: [GIFFavoriteItem] = {
        CoreDataManager.shared.fetchData(request: GIFFavoriteItem.fetchRequest())
    }()

    func pressFavoriteButton(item: GIFItem) {
        if checkDatabase(item: item) {
            CoreDataManager.shared.deleteGIFItem(object: gifFavoriteItemList.filter { $0.id == item.id }[0])
            gifFavoriteItemList = CoreDataManager.shared.fetchData(request: GIFFavoriteItem.fetchRequest())
        } else {
            CoreDataManager.shared.saveGIFItem(item: item)
            gifFavoriteItemList = CoreDataManager.shared.fetchData(request: GIFFavoriteItem.fetchRequest())
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
