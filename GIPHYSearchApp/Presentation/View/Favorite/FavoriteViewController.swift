//
//  FavoriteViewController.swift
//  GIPHYSearchApp
//
//  Created by 박근보 on 2022/05/02.
//

import UIKit
import Combine

final class FavoriteViewController: BaseViewController {

    private let mainView = FavoriteView()
    var viewModel: FavoriteViewModel?

    private var cancellables = Set<AnyCancellable>()

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

    override func configureView() {
        view.backgroundColor = .black
        mainView.favoriteCollectionView.delegate = self
        mainView.favoriteCollectionView.dataSource = self
        mainView.favoriteCollectionView.register(ContentCollectionViewCell.self, forCellWithReuseIdentifier: ContentCollectionViewCell.identifier)
    }

    override func configureNavigationItem() {
        navigationItem.title = "Favorite"
        navigationController?.navigationBar.titleTextAttributes = [.font: UIFont.boldSystemFont(ofSize: 21),
                                                                   .foregroundColor: UIColor.white]
    }

    // 데이터 바인딩
    private func bind() {
        viewModel?.$favoriteGIFs
            .sink { [weak self] gifs in
                self?.mainView.favoriteCollectionView.reloadData()
            }
            .store(in: &cancellables)

        viewModel?.$isEmpty
            .sink { [weak self] isEmpty in
                self?.mainView.noResultLabel.isHidden = isEmpty
            }
            .store(in: &cancellables)
    }

    private func getFavoriteGIFItem() {
        viewModel?.requestFavoriteGIFs()
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
        return viewModel?.favoriteGIFs.count ?? 0
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {

        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ContentCollectionViewCell.identifier, for: indexPath) as? ContentCollectionViewCell else { return UICollectionViewCell() }
        guard let viewModel = viewModel else { return UICollectionViewCell() }
        cell.cellConfig(gifURL: viewModel.favoriteGIFs[indexPath.row].previewURL ?? "")
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let viewModel = viewModel else { return }
        showDetailView(favoriteItem: viewModel.favoriteGIFs[indexPath.row])
    }
}
