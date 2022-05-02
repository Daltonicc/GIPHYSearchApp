//
//  SearchView.swift
//  GIPHYSearchApp
//
//  Created by 박근보 on 2022/05/02.
//

import UIKit

final class SearchView: BaseView {

    let textFieldView: TextFieldView = {
        let view = TextFieldView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    let categoryView: CategoryButtonView = {
        let view = CategoryButtonView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    let searchCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        layout.itemSize = CGSize(width: UIScreen.main.bounds.width / 3 - 20, height: UIScreen.main.bounds.width / 3 - 20)
        layout.minimumLineSpacing = 20
        layout.minimumInteritemSpacing = 10
        layout.sectionInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        layout.scrollDirection = .vertical
        collectionView.backgroundColor = .black
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        return collectionView
    }()
    let noResultLabel: UILabel = {
        let label = UILabel()
        label.text = "검색 결과가 없습니다."
        label.font = .systemFont(ofSize: 30)
        label.textColor = .systemGray4
        label.isHidden = true
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

        addSubview(textFieldView)
        addSubview(categoryView)
        addSubview(searchCollectionView)
        addSubview(noResultLabel)
    }

    override func setUpConstraint() {

        textFieldView.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor).isActive = true
        textFieldView.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
        textFieldView.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
        textFieldView.heightAnchor.constraint(equalToConstant: 40).isActive = true

        categoryView.topAnchor.constraint(equalTo: textFieldView.bottomAnchor, constant: 10).isActive = true
        categoryView.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
        categoryView.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
        categoryView.heightAnchor.constraint(equalToConstant: 40).isActive = true

        searchCollectionView.topAnchor.constraint(equalTo: categoryView.bottomAnchor).isActive = true
        searchCollectionView.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
        searchCollectionView.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
        searchCollectionView.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true

        noResultLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        noResultLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
    }
}
