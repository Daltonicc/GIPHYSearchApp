//
//  SearchCollectionViewCell.swift
//  GIPHYSearchApp
//
//  Created by 박근보 on 2022/05/02.
//

import UIKit

final class SearchCollectionViewCell: UICollectionViewCell {

    let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: "star")
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    let indicatorView: UIActivityIndicatorView = {
        let indicatorView = UIActivityIndicatorView()
        indicatorView.hidesWhenStopped = true
        indicatorView.translatesAutoresizingMaskIntoConstraints = false
        return indicatorView
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setUpCell()
        setUpConstraints()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }

    private func setUpCell() {
        contentView.addSubview(imageView)
        contentView.addSubview(indicatorView)
    }

    private func setUpConstraints() {

        imageView.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        imageView.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
        imageView.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
        imageView.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true

        indicatorView.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        indicatorView.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
        indicatorView.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
        indicatorView.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
    }

    func cellConfig(item: GIFItem) {
        let gifURL = item.images.preview.url
        imageView.setImageUrl(gifURL)
    }
}
