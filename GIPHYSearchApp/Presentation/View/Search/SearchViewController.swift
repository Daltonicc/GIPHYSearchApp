//
//  SearchViewController.swift
//  GIPHYSearchApp
//
//  Created by 박근보 on 2022/05/02.
//

import UIKit

class SearchViewController: BaseViewController {

    let mainView = SearchView()

    override func loadView() {
        self.view = mainView
    }

    override func viewDidLoad() {
        super.viewDidLoad()

    }

    override func setViewConfig() {
        super.setViewConfig()

        mainView.searchCollectionView.delegate = self
        mainView.searchCollectionView.dataSource = self
        mainView.searchCollectionView.register(SearchCollectionViewCell.self, forCellWithReuseIdentifier: SearchCollectionViewCell.identifier)
    }

    override func navigationItemConfig() {

        navigationItem.leftBarButtonItem = UIBarButtonItem(customView: mainView.titleLabel)
        navigationItem.rightBarButtonItem = mainView.favoriteBarButton
    }
}

extension SearchViewController: UICollectionViewDelegate, UICollectionViewDataSource {

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 30
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SearchCollectionViewCell.identifier, for: indexPath) as? SearchCollectionViewCell else { return UICollectionViewCell() }

        return cell
    }


}
