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
        layout.itemSize = CGSize(width: UIScreen.main.bounds.width / 2 - 2, height: UIScreen.main.bounds.width / 3 - 20)
        layout.minimumLineSpacing = 2
        layout.minimumInteritemSpacing = 2
        layout.sectionInset = UIEdgeInsets(top: 5, left: 0, bottom: 0, right: 0)
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
    let gradientView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.isUserInteractionEnabled = false
        return view
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
        addSubview(gradientView)
    }

    override func setUpConstraint() {

        textFieldView.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor).isActive = true
        textFieldView.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
        textFieldView.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
        textFieldView.heightAnchor.constraint(equalToConstant: 50).isActive = true

        categoryView.topAnchor.constraint(equalTo: textFieldView.bottomAnchor, constant: 5).isActive = true
        categoryView.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
        categoryView.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
        categoryView.heightAnchor.constraint(equalToConstant: 50).isActive = true

        searchCollectionView.topAnchor.constraint(equalTo: categoryView.bottomAnchor).isActive = true
        searchCollectionView.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
        searchCollectionView.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
        searchCollectionView.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true

        noResultLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        noResultLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true

        gradientView.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
        gradientView.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
        gradientView.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        gradientView.heightAnchor.constraint(equalToConstant: 250).isActive = true
    }

    func gradientConfig() {

        gradientView.setGradient(startColor: UIColor(red: 50/255, green: 50/255, blue: 50/255, alpha: 0),
                                          finishColor: UIColor(red: 0/255, green: 0/255, blue: 0/255, alpha: 0.3),
                                          start: CGPoint(x: 1.0, y: 0.0),
                                          end: CGPoint(x: 1.0, y: 1.0))
        textFieldView.buttonView.setGradient(startColor: UIColor(red: 253/255, green: 122/255, blue: 255/255, alpha: 1),
                                                      finishColor: UIColor(red: 196/255, green: 24/255, blue: 188/255, alpha: 1),
                                                      start: CGPoint(x: 1.0, y: 0.0),
                                                      end: CGPoint(x: 0.0, y: 1.0))
    }
}
