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

    override func viewWillAppear(_ animated: Bool) {
        getFavoriteGIFItem()
        bind()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
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

    private func getFavoriteGIFItem() {
        viewModel?.fetchFavoriteGIFItemList(completion: { [weak self] bool in
            guard let self = self else { return }
            print(bool)
            self.mainView.noResultLabel.isHidden = bool
        })
    }

    private func showDetailView(favoriteItem: GIFFavoriteItem) {
        let vc = DetailViewController()
        vc.favoriteItem = favoriteItem
        vc.viewModel = DetailViewModel()
        navigationController?.pushViewController(vc, animated: true)
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

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let viewModel = viewModel else { return }
        showDetailView(favoriteItem: viewModel.gifFavoriteItemList.value[indexPath.row])
    }
}
