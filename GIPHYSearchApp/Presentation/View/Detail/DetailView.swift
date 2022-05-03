//
//  DetailView.swift
//  GIPHYSearchApp
//
//  Created by 박근보 on 2022/05/03.
//

import UIKit

final class DetailView: BaseView {

    let scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.isScrollEnabled = true
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        return scrollView
    }()
    let contentView: ContentGIFView = {
        let view = ContentGIFView()
        view.imageView.contentMode = .center
        view.imageView.layer.cornerRadius = 5
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    let userImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.backgroundColor = .systemPink
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    let usernameLabel: UILabel = {
        let label = UILabel()
        label.font = .boldSystemFont(ofSize: 20)
        label.textColor = .white
        label.textAlignment = .center
        label.text = "username"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    let favoriteButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "heart.fill"), for: .normal)
        button.tintColor = .white
        button.contentVerticalAlignment = .fill
        button.contentHorizontalAlignment = .fill
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }

    override func setUpView() {

        addSubview(scrollView)
        scrollView.addSubview(contentView)
        scrollView.addSubview(userImageView)
        scrollView.addSubview(usernameLabel)
        scrollView.addSubview(favoriteButton)
    }

    override func setUpConstraint() {

        scrollView.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor).isActive = true
        scrollView.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
        scrollView.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
        scrollView.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true

        contentView.topAnchor.constraint(equalTo: scrollView.topAnchor).isActive = true
        contentView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 10).isActive = true
        contentView.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.width - 20).isActive = true

        userImageView.topAnchor.constraint(equalTo: contentView.bottomAnchor, constant: 10).isActive = true
        userImageView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 10).isActive = true
        userImageView.widthAnchor.constraint(equalToConstant: 50).isActive = true
        userImageView.heightAnchor.constraint(equalToConstant: 50).isActive = true

        usernameLabel.topAnchor.constraint(equalTo: contentView.bottomAnchor, constant: 10).isActive = true
        usernameLabel.leadingAnchor.constraint(equalTo: userImageView.trailingAnchor, constant: 10).isActive = true
        usernameLabel.heightAnchor.constraint(equalToConstant: 40).isActive = true

        favoriteButton.topAnchor.constraint(equalTo: contentView.bottomAnchor, constant: 10).isActive = true
        favoriteButton.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -10).isActive = true
        favoriteButton.heightAnchor.constraint(equalToConstant: 40).isActive = true
        favoriteButton.widthAnchor.constraint(equalToConstant: 40).isActive = true
    }
}
