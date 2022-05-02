//
//  SearchView.swift
//  GIPHYSearchApp
//
//  Created by 박근보 on 2022/05/02.
//

import UIKit

final class SearchView: BaseView {

    let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "GIPHY Search"
        label.font = .boldSystemFont(ofSize: 25)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    let favoriteBarButton: UIBarButtonItem = {
        let barButton = UIBarButtonItem(title: "즐겨찾기", style: .plain, target: nil, action: nil)
        barButton.tintColor = .black
        return barButton
    }()
    let searchBar: UISearchBar = {
        let searchBar = UISearchBar()
        searchBar.placeholder = "검색어를 입력해주세요"
        searchBar.searchBarStyle = .minimal
        searchBar.translatesAutoresizingMaskIntoConstraints = false
        return searchBar
    }()
    let imageCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        layout.itemSize = CGSize(width: UIScreen.main.bounds.width / 3 - 20, height: UIScreen.main.bounds.width / 3 - 20)
        layout.minimumLineSpacing = 20
        layout.minimumInteritemSpacing = 10
        layout.sectionInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        layout.scrollDirection = .vertical
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        return collectionView
    }()
    let noResultLabel: UILabel = {
        let label = UILabel()
        label.text = "검색 결과가 없습니다."
        label.font = .systemFont(ofSize: 30)
        label.textColor = .systemGray4
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }

    override func setUpView() {

        addSubview(searchBar)
        addSubview(imageCollectionView)
        addSubview(noResultLabel)
    }

    override func setUpConstraint() {

        searchBar.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor).isActive = true
        searchBar.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
        searchBar.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true

        imageCollectionView.topAnchor.constraint(equalTo: searchBar.bottomAnchor).isActive = true
        imageCollectionView.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
        imageCollectionView.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
        imageCollectionView.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true

        noResultLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        noResultLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
    }
}
