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
    private var datasource: UICollectionViewDiffableDataSource<Int, GIFFavoriteItem>!

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
        mainView.favoriteCollectionView.dataSource = datasource
        mainView.favoriteCollectionView.register(ContentCollectionViewCell.self, forCellWithReuseIdentifier: ContentCollectionViewCell.identifier)

        configureDatasource()
    }

    override func configureNavigationItem() {
        navigationItem.title = "Favorite"
        navigationController?.navigationBar.titleTextAttributes = [.font: UIFont.boldSystemFont(ofSize: 21),
                                                                   .foregroundColor: UIColor.white]
    }

    private func configureDatasource() {
        datasource = UICollectionViewDiffableDataSource(collectionView: mainView.favoriteCollectionView, cellProvider: { collectionView, indexPath, gif in
                  guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ContentCollectionViewCell.identifier, for: indexPath) as? ContentCollectionViewCell else {
                return UICollectionViewCell()
            }
            cell.cellConfig(gifURL: gif.previewURL ?? "")

            return cell
        })
    }

    // 데이터 바인딩
    private func bind() {
        viewModel?.$favoriteGIFs
            .sink { [weak self] gifs in
                var snapshot = NSDiffableDataSourceSnapshot<Int, GIFFavoriteItem>()

                snapshot.appendSections([0])
                snapshot.appendItems(gifs)

                self?.datasource.apply(snapshot)
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

extension FavoriteViewController: UICollectionViewDelegate {

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel?.favoriteGIFs.count ?? 0
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let viewModel = viewModel else { return }
        showDetailView(favoriteItem: viewModel.favoriteGIFs[indexPath.row])
    }
}
