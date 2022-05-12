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

    func cellConfig(gifURL: String) {
        cellView.indicatorAction(bool: true)
        DispatchQueue.global().async { [weak self] in
            let image = UIImage.gifImageWithURL(gifURL)
            DispatchQueue.main.async {
                self?.cellView.imageView.image = image
                self?.cellView.indicatorAction(bool: false)
            }
        }
    }
}
