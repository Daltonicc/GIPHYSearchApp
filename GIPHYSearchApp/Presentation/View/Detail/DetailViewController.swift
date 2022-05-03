//
//  DetailViewController.swift
//  GIPHYSearchApp
//
//  Created by 박근보 on 2022/05/03.
//

import UIKit

final class DetailViewController: BaseViewController {

    private let mainView = DetailView()
    var viewModel: DetailViewModel?

    var item: GIFItem?
    var isFavorite = false

    override func loadView() {
        self.view = mainView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .black
        contentViewConfig()
    }

    override func setViewConfig() {

        mainView.favoriteButton.addTarget(self, action: #selector(favoriteButtonClicked), for: .touchUpInside)
    }

    override func navigationItemConfig() {
        
        navigationItem.leftBarButtonItem = backBarButton
    }

    private func contentViewConfig() {
        guard let item = item else { return }
        guard let viewModel = viewModel else { return }

        let height: Int32 = Int32(item.images.original.height) ?? 0
        isFavorite = viewModel.checkDatabase(item: item)
        mainView.contentView.indicatorAction(bool: true)
        mainView.userImageView.setImageUrl(item.user.avatarURL)
        mainView.contentView.heightAnchor.constraint(equalToConstant: CGFloat(height)).isActive = true
        mainView.usernameLabel.text = item.user.name
        mainView.favoriteButton.tintColor = isFavorite ? .systemRed : .white
        let gifURL = item.images.original.url
        DispatchQueue.main.async { [weak self] in
            self?.mainView.contentView.imageView.image = UIImage.gifImageWithURL(gifURL)
            self?.mainView.contentView.indicatorAction(bool: false)
        }
    }

    @objc private func favoriteButtonClicked() {
        addPressAnimationToButton(scale: 0.85, mainView.favoriteButton) { [weak self] _ in
            guard let self = self else { return }
            guard let item = self.item else { return }
            guard let viewModel = self.viewModel else { return }

            self.isFavorite.toggle()
            self.mainView.favoriteButton.tintColor = self.isFavorite ? .systemRed : .white
            viewModel.pressFavoriteButton(item: item)
        }

    }
}

