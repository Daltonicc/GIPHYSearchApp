//
//  FavoriteView.swift
//  GIPHYSearchApp
//
//  Created by 박근보 on 2022/05/04.
//

import UIKit

final class FavoriteView: BaseView {

    let favoriteCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        layout.itemSize = CGSize(width: UIScreen.main.bounds.width / 2 - 2, height: UIScreen.main.bounds.width / 3 - 20)
        layout.minimumLineSpacing = 2
        layout.minimumInteritemSpacing = 2
        layout.sectionInset = UIEdgeInsets(top: 5, left: 0, bottom: 0, right: 0)
        layout.scrollDirection = .vertical
        collectionView.backgroundColor = .black
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        return collectionView
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }

    override func setUpView() {

        addSubview(favoriteCollectionView)
    }

    override func setUpConstraint() {

        favoriteCollectionView.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor).isActive = true
        favoriteCollectionView.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
        favoriteCollectionView.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
        favoriteCollectionView.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
    }
}
