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
    var favoriteItem: GIFFavoriteItem?
    var isFavorite = false

    override func loadView() {
        self.view = mainView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .black
        contentViewConfigBySearch()
        contentViewConfigByFavorite()
    }

    override func setViewConfig() {
        mainView.favoriteButton.addTarget(self, action: #selector(favoriteButtonClicked), for: .touchUpInside)
    }

    override func navigationItemConfig() {
        navigationItem.leftBarButtonItem = backBarButton
    }

    private func contentViewConfig(avatar: String, gif: String, name: String, height: String, isFavorite: Bool) {
        let height: Int32 = Int32(height) ?? 0

        mainView.contentView.indicatorAction(bool: true)
        mainView.userImageView.setImageUrl(avatar)
        mainView.usernameLabel.text = name
        mainView.favoriteButton.tintColor = isFavorite ? .systemRed : .white
        mainView.contentView.heightAnchor.constraint(equalToConstant: CGFloat(height)).isActive = true

        DispatchQueue.main.async { [weak self] in
            self?.mainView.contentView.imageView.image = UIImage.gifImageWithURL(gif)
            self?.mainView.contentView.indicatorAction(bool: false)
        }
    }

    private func contentViewConfigBySearch() {
        guard let item = item else { return }
        guard let viewModel = viewModel else { return }
        isFavorite = viewModel.checkDatabase(item: item)
        contentViewConfig(avatar: item.user.avatarURL,
                          gif: item.images.original.url,
                          name: item.user.name,
                          height: item.images.original.height,
                          isFavorite: isFavorite)
    }

    private func contentViewConfigByFavorite() {
        guard let favoriteItem = favoriteItem else { return }
        isFavorite = true
        contentViewConfig(avatar: favoriteItem.avatarURL ?? "",
                          gif: favoriteItem.originalURL ?? "",
                          name: favoriteItem.username ?? "",
                          height: favoriteItem.originalHeight ?? "",
                          isFavorite: favoriteItem.isFavorite)
    }

    private func removeAlert() {

    }

    @objc private func favoriteButtonClicked() {
        addPressAnimationToButton(scale: 0.85, mainView.favoriteButton) { [weak self] _ in
            guard let self = self else { return }
            guard let viewModel = self.viewModel else { return }

            self.isFavorite.toggle()
            self.mainView.favoriteButton.tintColor = self.isFavorite ? .systemRed : .white
            viewModel.pressFavoriteButton(item: self.item, favoriteItem: self.favoriteItem) {
                self.removeAlert()
            }
        }
    }
}

