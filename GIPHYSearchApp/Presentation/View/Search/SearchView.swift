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
    var searchCollectionView: UICollectionView!
    let noResultLabel: UILabel = {
        let label = UILabel()
        label.text = "No Datas Found"
        label.font = .boldSystemFont(ofSize: 30)
        label.textColor = .white
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

    private var viewGradientLayer = CAGradientLayer()
    private var buttonGradientLayer = CAGradientLayer()

    override init(frame: CGRect) {
        super.init(frame: frame)
        configureGradient()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        configureGradient()
    }

    override func layout() {

        addSubview(textFieldView)
        textFieldView.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor).isActive = true
        textFieldView.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
        textFieldView.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
        textFieldView.heightAnchor.constraint(equalToConstant: 50).isActive = true

        addSubview(categoryView)
        categoryView.topAnchor.constraint(equalTo: textFieldView.bottomAnchor, constant: 5).isActive = true
        categoryView.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
        categoryView.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
        categoryView.heightAnchor.constraint(equalToConstant: 50).isActive = true

        configureCollectionView()
        addSubview(searchCollectionView)
        searchCollectionView.topAnchor.constraint(equalTo: categoryView.bottomAnchor, constant: 5).isActive = true
        searchCollectionView.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
        searchCollectionView.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
        searchCollectionView.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true

        addSubview(noResultLabel)
        noResultLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        noResultLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true

        addSubview(gradientView)
        gradientView.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
        gradientView.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
        gradientView.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        gradientView.heightAnchor.constraint(equalToConstant: 250).isActive = true
    }

    override func layoutSubviews() {
        super.layoutSubviews()

        viewGradientLayer.frame = gradientView.bounds
        buttonGradientLayer.frame = textFieldView.searchButton.bounds
    }

    private func configureCollectionView() {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: makeCollectionViewLayout())
        collectionView.backgroundColor = .black
        searchCollectionView = collectionView
        searchCollectionView.translatesAutoresizingMaskIntoConstraints = false
    }

    private func makeCollectionViewLayout() -> UICollectionViewLayout {
        let mainItem = NSCollectionLayoutItem(
            layoutSize: NSCollectionLayoutSize(
                widthDimension: .fractionalWidth(2/3),
                heightDimension: .fractionalHeight(1.0)))
        mainItem.contentInsets = NSDirectionalEdgeInsets(top: 2, leading: 2, bottom: 2, trailing: 2)

        let pairItem = NSCollectionLayoutItem(
            layoutSize: NSCollectionLayoutSize(
                widthDimension: .fractionalWidth(1.0),
                heightDimension: .fractionalHeight(0.5)))
        pairItem.contentInsets = NSDirectionalEdgeInsets(top: 2, leading: 2, bottom: 2, trailing: 2)

        let pairGroup = NSCollectionLayoutGroup.vertical(
              layoutSize: NSCollectionLayoutSize(
                widthDimension: .fractionalWidth(1/3),
                heightDimension: .fractionalHeight(1.0)),
              subitem: pairItem,
              count: 2)

        let mainWithPairGroup = NSCollectionLayoutGroup.horizontal(
            layoutSize: NSCollectionLayoutSize(
                widthDimension: .fractionalWidth(1.0),
                heightDimension: .fractionalWidth(4/9)),
            subitems: [mainItem, pairGroup])

        let tripletItem = NSCollectionLayoutItem(
            layoutSize: NSCollectionLayoutSize(
                widthDimension: .fractionalWidth(1/3),
                heightDimension: .fractionalHeight(1.0)))
        tripletItem.contentInsets = NSDirectionalEdgeInsets(top: 2, leading: 2, bottom: 2, trailing: 2)

        let tripletGroup = NSCollectionLayoutGroup.horizontal(
            layoutSize: NSCollectionLayoutSize(
                widthDimension: .fractionalWidth(1.0),
                heightDimension: .fractionalWidth(2/9)),
            subitems: [tripletItem, tripletItem, tripletItem])

        let mainWithPairReversedGroup = NSCollectionLayoutGroup.horizontal(
            layoutSize: NSCollectionLayoutSize(
                widthDimension: .fractionalWidth(1.0),
                heightDimension: .fractionalWidth(4/9)),
            subitems: [pairGroup, mainItem])

        let nestedGroup = NSCollectionLayoutGroup.vertical(
            layoutSize: NSCollectionLayoutSize(
                widthDimension: .fractionalWidth(1.0),
                heightDimension: .fractionalWidth(16/9)),
            subitems: [mainWithPairGroup, tripletGroup, mainWithPairReversedGroup])

        let section = NSCollectionLayoutSection(group: nestedGroup)
        let layout = UICollectionViewCompositionalLayout(section: section)

        return layout
    }

    func configureGradient() {
        
        gradientView.setGradient(gradient: viewGradientLayer,
                                 startColor: UIColor(red: 100/255, green: 100/255, blue: 50/255, alpha: 0),
                                 finishColor: UIColor(red: 0/255, green: 0/255, blue: 0/255, alpha: 1),
                                 start: CGPoint(x: 1.0, y: 0.0),
                                 end: CGPoint(x: 1.0, y: 1.0))
        textFieldView.buttonView.setGradient(gradient: buttonGradientLayer,
                                             startColor: UIColor(red: 253/255, green: 122/255, blue: 255/255, alpha: 1),
                                             finishColor: UIColor(red: 196/255, green: 24/255, blue: 188/255, alpha: 1),
                                             start: CGPoint(x: 1.0, y: 0.0),
                                             end: CGPoint(x: 0.0, y: 1.0))
    }
}
