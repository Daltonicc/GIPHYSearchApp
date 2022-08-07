//
//  FavoriteViewModel.swift
//  GIPHYSearchApp
//
//  Created by 박근보 on 2022/05/04.
//

import Foundation

protocol FavoriteViewModelInput {
    func requestFavoriteGIFs()
}

final class FavoriteViewModel {
    @Published var favoriteGIFs: [GIFFavoriteItem] = []
    @Published var isEmpty = true
}

extension FavoriteViewModel: FavoriteViewModelInput {
    func requestFavoriteGIFs() {
        favoriteGIFs = CoreDataManager.shared.fetchData(request: GIFFavoriteItem.fetchRequest())
        isEmpty = isFavoriteGIFsEmpty()
    }
}

extension FavoriteViewModel {
    private func isFavoriteGIFsEmpty() -> Bool {
        if favoriteGIFs.isEmpty {
            return false
        } else {
            return true
        }
    }
}
