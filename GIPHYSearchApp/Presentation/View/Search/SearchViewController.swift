//
//  SearchViewController.swift
//  GIPHYSearchApp
//
//  Created by 박근보 on 2022/05/02.
//

import UIKit

class SearchViewController: BaseViewController {

    private let mainView = SearchView()
    var viewModel: SearchViewModel?

    override func loadView() {
        self.view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bind()
    }

    override func setViewConfig() {
        mainView.searchCollectionView.delegate = self
        mainView.searchCollectionView.dataSource = self
        mainView.searchCollectionView.keyboardDismissMode = .onDrag
        mainView.searchCollectionView.register(ContentCollectionViewCell.self, forCellWithReuseIdentifier: ContentCollectionViewCell.identifier)

        mainView.textFieldView.textField.delegate = self
        mainView.textFieldView.searchButton.addTarget(self, action: #selector(searchButtonClicked), for: .touchUpInside)

        mainView.categoryView.delegate = self
    }

    override func navigationItemConfig() {
        navigationItem.title = "Search"
        navigationController?.navigationBar.titleTextAttributes = [.font: UIFont.boldSystemFont(ofSize: 21),
                                                                   .foregroundColor: UIColor.white]
    }

    // 데이터 바인딩
    private func bind() {
        viewModel?.gifData.bind({ [weak self] item in
            guard let self = self else { return }
            self.mainView.searchCollectionView.reloadData()
        })

        viewModel?.navigationTitle.bind({ [weak self] title in
            guard let self = self else { return }
            self.navigationItem.title = title
        })
    }

    // GIF Requset
    private func requestGIFData() {
        guard let query = mainView.textFieldView.textField.text else { return }
        guard query.count >= 1 else { return }
        viewModel?.requestGIFData(style: mainView.categoryView.status, query: query, completion: { [weak self] bool, error in
            guard let self = self else { return }
            if let error = error {
                self.showToast(vc: self, message: error)
            }
            self.mainView.noResultLabel.isHidden = bool
        })
    }

    // Pagination
    private func requestNextPageData() {
        guard let query = mainView.textFieldView.textField.text else { return }
        guard query.count >= 1 else { return }
        viewModel?.requestNextGIFData(style: mainView.categoryView.status, query: query, completion: { [weak self] error in
            guard let self = self else { return }
            if let error = error {
                self.showToast(vc: self, message: error)
            }
        })
    }

    // 디테일 뷰 이동
    private func showDetailView(item: GIFItem) {
        let vc = DetailViewController()
        switch mainView.categoryView.status {
        case .gif: vc.title = "GIF"
        case .sticker: vc.title = "Sticker"
        case .text: vc.title = "Text"
        }
        vc.item = item
        vc.viewModel = DetailViewModel()
        navigationController?.pushViewController(vc, animated: true)
    }
}

// TextField Logic
extension SearchViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        requestGIFData()
        textField.resignFirstResponder()
        return true
    }

    @objc private func searchButtonClicked() {
        requestGIFData()
        mainView.textFieldView.textField.resignFirstResponder()
    }
}

// CategoryButtonDelegate - 카테고리 바뀌면 API 호출
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
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ContentCollectionViewCell.identifier, for: indexPath) as? ContentCollectionViewCell else { return UICollectionViewCell() }
        guard let viewModel = viewModel else { return UICollectionViewCell() }
        cell.cellConfig(gifURL: viewModel.gifData.value[indexPath.row].images.preview.url)

        // 마지막 데이터인지 확인하고 다음 페이지 요청
        if indexPath.row == viewModel.gifData.value.count - 1 {
            requestNextPageData()
        }
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let viewModel = viewModel else { return }
        showDetailView(item: viewModel.gifData.value[indexPath.row])
    }
}
