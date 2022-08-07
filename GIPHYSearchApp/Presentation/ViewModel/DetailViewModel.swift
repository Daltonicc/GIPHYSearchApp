//
//  DetailViewModel.swift
//  GIPHYSearchApp
//
//  Created by 박근보 on 2022/05/03.
//

import Foundation

protocol DetailViewModelProtocol {
    func didTapFavoriteButton(item: GIFItem?, favoriteItem: GIFFavoriteItem?, completion: (() -> Void)?)
    func isFavoriteGIFsEmpty(item: GIFItem) -> Bool
}

final class DetailViewModel: DetailViewModelProtocol {

    private var favoriteGIFs: [GIFFavoriteItem] = {
        CoreDataManager.shared.fetchData(request: GIFFavoriteItem.fetchRequest())
    }()

    // 좋아요 버튼 눌렀을 때 로직
    func didTapFavoriteButton(item: GIFItem?, favoriteItem: GIFFavoriteItem?, completion: (() -> Void)?) {
        // 검색 목록에서 눌렀을 때
        if let item = item {
            if isFavoriteGIFsEmpty(item: item) {
                CoreDataManager.shared.deleteGIFItem(object: favoriteGIFs.filter { $0.id == item.id }[0])
                favoriteGIFs = CoreDataManager.shared.fetchData(request: GIFFavoriteItem.fetchRequest())
            } else {
                CoreDataManager.shared.saveGIFItem(item: item)
                favoriteGIFs = CoreDataManager.shared.fetchData(request: GIFFavoriteItem.fetchRequest())
            }
        }
        // 즐겨찾기 목록에서 눌렀을 때
        if let favoriteItem = favoriteItem {
            CoreDataManager.shared.deleteGIFItem(object: favoriteItem)
            completion!()
        }
    }

    // 데이터베이스에 해당 데이터 있는지 확인
    func isFavoriteGIFsEmpty(item: GIFItem) -> Bool {
        let filterValue = favoriteGIFs.filter { $0.id == item.id }
        if filterValue.count >= 1 {
            return true
        } else {
            return false
        }
    }
}
