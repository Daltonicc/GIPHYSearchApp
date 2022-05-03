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
        mainView.searchCollectionView.keyboardDismissMode = .onDrag
        mainView.searchCollectionView.register(SearchCollectionViewCell.self, forCellWithReuseIdentifier: SearchCollectionViewCell.identifier)

        mainView.textFieldView.textField.delegate = self
        mainView.textFieldView.searchButton.addTarget(self, action: #selector(searchButtonClicked), for: .touchUpInside)

        mainView.categoryView.delegate = self
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

    private func requestGIFData() {
        guard let query = mainView.textFieldView.textField.text else { return }
        viewModel?.requestGIFData(style: mainView.categoryView.status, query: query, completion: { [weak self] error in
            guard let self = self else { return }
            guard let error = error else { return }
            self.showToast(vc: self, message: error)
        })
    }

    @objc private func searchButtonClicked() {
        requestGIFData()
        mainView.textFieldView.textField.resignFirstResponder()
    }
}

extension SearchViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        requestGIFData()
        textField.resignFirstResponder()
        return true
    }
}

extension SearchViewController: CategoryButtonDelegate {
    func didTapCategoryButton() {
        requestGIFData()
    }
}

extension SearchViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel?.gifData.value.count ?? 0
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SearchCollectionViewCell.identifier, for: indexPath) as? SearchCollectionViewCell else { return UICollectionViewCell() }
        guard let viewModel = viewModel else { return UICollectionViewCell() }
        cell.cellConfig(item: viewModel.gifData.value[indexPath.row])
        return cell
    }
}
