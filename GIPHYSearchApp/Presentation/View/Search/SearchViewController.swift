//
//  SearchViewController.swift
//  GIPHYSearchApp
//
//  Created by 박근보 on 2022/05/02.
//

import UIKit

class SearchViewController: BaseViewController {

    let mainView = SearchView()
    var viewModel: SearchViewModel?

    override func loadView() {
        self.view = mainView
    }

    override func viewDidLayoutSubviews() {

        mainView.gradientConfig()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        bind()
    }

    override func setViewConfig() {

        mainView.searchCollectionView.delegate = self
        mainView.searchCollectionView.dataSource = self
        mainView.searchCollectionView.register(SearchCollectionViewCell.self, forCellWithReuseIdentifier: SearchCollectionViewCell.identifier)
    }

    override func navigationItemConfig() {

        navigationItem.title = "Search"
        navigationController?.navigationBar.titleTextAttributes = [.foregroundColor: UIColor.white]
    }

    private func bind() {

        viewModel?.gifData.bind { [weak self] item in
            guard let self = self else { return }
            self.mainView.searchCollectionView.reloadData()
        }
    }

}

extension SearchViewController: UICollectionViewDelegate, UICollectionViewDataSource {

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel?.gifData.value.count ?? 0
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SearchCollectionViewCell.identifier, for: indexPath) as? SearchCollectionViewCell else { return UICollectionViewCell() }
        guard let viewModel = viewModel else { return UICollectionViewCell() }

        cell.imageView.backgroundColor = .white
        cell.cellConfig(item: viewModel.gifData.value[indexPath.row])
        return cell
    }
}
