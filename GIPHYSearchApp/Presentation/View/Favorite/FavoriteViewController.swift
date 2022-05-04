//
//  FavoriteViewController.swift
//  GIPHYSearchApp
//
//  Created by 박근보 on 2022/05/02.
//

import UIKit

final class FavoriteViewController: BaseViewController {

    private let mainView = FavoriteView()
    var viewModel: FavoriteViewModel?

    override func loadView() {
        self.view = mainView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        bind()
        getFavoriteGIFItem()
    }

    override func setViewConfig() {
        view.backgroundColor = .black
        mainView.favoriteCollectionView.delegate = self
        mainView.favoriteCollectionView.dataSource = self
        mainView.favoriteCollectionView.register(ContentCollectionViewCell.self, forCellWithReuseIdentifier: ContentCollectionViewCell.identifier)
    }

    override func navigationItemConfig() {
        navigationItem.title = "Favorite"
        navigationController?.navigationBar.titleTextAttributes = [.font: UIFont.boldSystemFont(ofSize: 21),
                                                                   .foregroundColor: UIColor.white]
    }

    private func bind() {

        viewModel?.gifFavoriteItemList.bind({ [weak self] item in
            guard let self = self else { return }
            self.mainView.favoriteCollectionView.reloadData()
        })
    }

    private func showDetailView(item: GIFItem) {
        let vc = DetailViewController()
        vc.item = item
        vc.viewModel = DetailViewModel()
        navigationController?.pushViewController(vc, animated: true)
    }

    private func getFavoriteGIFItem() {
        viewModel?.fetchFavoriteGIFItemList()
    }
}

extension FavoriteViewController: UICollectionViewDelegate, UICollectionViewDataSource {

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel?.gifFavoriteItemList.value.count ?? 0
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {

        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ContentCollectionViewCell.identifier, for: indexPath) as? ContentCollectionViewCell else { return UICollectionViewCell() }
        guard let viewModel = viewModel else { return UICollectionViewCell() }
        cell.cellConfig(gifURL: viewModel.gifFavoriteItemList.value[indexPath.row].previewURL ?? "")
        return cell
    }
}
