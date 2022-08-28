//
//  ContentGIFView.swift
//  GIPHYSearchApp
//
//  Created by 박근보 on 2022/05/03.
//

import UIKit

final class ContentGIFView: BaseView {

    let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.backgroundColor = .black
        imageView.layer.masksToBounds = true
        return imageView
    }()
    let indicatorView: UIActivityIndicatorView = {
        let indicatorView = UIActivityIndicatorView()
        indicatorView.hidesWhenStopped = true
        indicatorView.color = .white
        indicatorView.backgroundColor = .black
        return indicatorView
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        layout()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }

    override func layout() {
        addSubview(imageView)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: self.topAnchor),
            imageView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            imageView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            imageView.bottomAnchor.constraint(equalTo: self.bottomAnchor)
        ])

        addSubview(indicatorView)
        indicatorView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            indicatorView.topAnchor.constraint(equalTo: self.topAnchor),
            indicatorView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            indicatorView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            indicatorView.bottomAnchor.constraint(equalTo: self.bottomAnchor)
        ])
    }

    func indicatorAction(bool: Bool) {
        if bool {
            indicatorView.isHidden = false
            indicatorView.startAnimating()
        } else {
            indicatorView.isHidden = true
            indicatorView.stopAnimating()
        }
    }
}
