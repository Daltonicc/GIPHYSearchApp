//
//  SearchViewController.swift
//  GIPHYSearchApp
//
//  Created by 박근보 on 2022/05/02.
//

import UIKit
import Combine

class SearchViewController: BaseViewController {

    private let mainView = SearchView()
    var viewModel: SearchViewModel?

    private var cancellables = Set<AnyCancellable>()
    private var datasource: UICollectionViewDiffableDataSource<Int, GIFItem>!

    override func loadView() {
        self.view = mainView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        bind()
    }

    override func configureView() {
        mainView.searchCollectionView.delegate = self
        mainView.searchCollectionView.dataSource = datasource
        mainView.searchCollectionView.keyboardDismissMode = .onDrag
        mainView.searchCollectionView.register(ContentCollectionViewCell.self, forCellWithReuseIdentifier: ContentCollectionViewCell.identifier)

        mainView.textFieldView.textField.delegate = self
        mainView.textFieldView.searchButton.addTarget(self, action: #selector(searchButtonClicked), for: .touchUpInside)

        mainView.categoryView.delegate = self
        viewModel?.outputDelegate = self

        configureDatasource()
    }

    override func configureNavigationItem() {
        navigationItem.title = "Search"
        navigationController?.navigationBar.titleTextAttributes = [.font: UIFont.boldSystemFont(ofSize: 21),
                                                                   .foregroundColor: UIColor.white]
    }

    private func configureDatasource() {
        datasource = UICollectionViewDiffableDataSource(collectionView: mainView.searchCollectionView, cellProvider: { [weak self] collectionView, indexPath, gif in
            guard let self = self,
                  let viewModel = self.viewModel,
                  let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ContentCollectionViewCell.identifier, for: indexPath) as? ContentCollectionViewCell else {
                return UICollectionViewCell()
            }
            cell.cellConfig(gifURL: gif.images.preview.url)

            if indexPath.row == viewModel.gifs.count - 1 {
                self.requestNextPageData()
            }

            return cell
        })
    }

    // 데이터 바인딩
    private func bind() {
        viewModel?.$gifs
            .receive(on: DispatchQueue.main)
            .sink { [weak self] gifs in
                var snapshot = NSDiffableDataSourceSnapshot<Int, GIFItem>()

                snapshot.appendSections([0])
                snapshot.appendItems(gifs)

                self?.datasource.apply(snapshot)
            }
            .store(in: &cancellables)

        viewModel?.$navigationTitle
            .receive(on: DispatchQueue.main)
            .sink { [weak self] title in
                self?.navigationItem.title = title
            }
            .store(in: &cancellables)

        viewModel?.$isEmpty
            .receive(on: DispatchQueue.main)
            .sink { [weak self] isEmpty in
                self?.mainView.noResultLabel.isHidden = isEmpty
            }
            .store(in: &cancellables)
    }

    private func requestGIFData() {
        guard let query = mainView.textFieldView.textField.text else {
            return
        }
        if query.isEmpty {
            return
        }

        Task {
            await viewModel?.requestGIFs(style: mainView.categoryView.status, query: query)
        }
    }

    private func requestNextPageData() {
        guard let query = mainView.textFieldView.textField.text else {
            return
        }
        if query.isEmpty {
            return
        }

        Task {
            await viewModel?.requestNextGIFs(style: mainView.categoryView.status, query: query)
        }
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

extension SearchViewController: SearchViewModelOutput {
    func showErrorToast(_ errorMessage: String) {
        DispatchQueue.main.async {
            self.showToast(vc: self, message: errorMessage)
        }
    }
}

extension SearchViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel?.gifs.count ?? 0
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ContentCollectionViewCell.identifier, for: indexPath) as? ContentCollectionViewCell else { return UICollectionViewCell() }
        guard let viewModel = viewModel else { return UICollectionViewCell() }
        cell.cellConfig(gifURL: viewModel.gifs[indexPath.row].images.preview.url)

        // 마지막 데이터인지 확인하고 다음 페이지 요청
        if indexPath.row == viewModel.gifs.count - 1 {
            requestNextPageData()
        }
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let viewModel = viewModel else { return }
        showDetailView(item: viewModel.gifs[indexPath.row])
    }
}
