//
//  SearchCollectionViewCell.swift
//  GIPHYSearchApp
//
//  Created by 박근보 on 2022/05/02.
//

import UIKit

final class ContentCollectionViewCell: UICollectionViewCell {

    let cellView: ContentGIFView = {
        let view = ContentGIFView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
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
        contentView.addSubview(cellView)
    }

    private func setUpConstraints() {

        cellView.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        cellView.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
        cellView.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
        cellView.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
    }

    func cellConfig(item: GIFItem) {
        cellView.indicatorAction(bool: true)
        let gifURL = item.images.preview.url
        DispatchQueue.main.async { [weak self] in
            self?.cellView.imageView.image = UIImage.gifImageWithURL(gifURL)
            self?.cellView.indicatorAction(bool: false)
        }
    }
}
