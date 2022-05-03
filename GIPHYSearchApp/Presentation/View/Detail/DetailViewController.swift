//
//  DetailViewController.swift
//  GIPHYSearchApp
//
//  Created by 박근보 on 2022/05/03.
//

import UIKit

final class DetailViewController: BaseViewController {

    private let mainView = DetailView()
    var item: GIFItem?

    override func loadView() {
        self.view = mainView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .black
    }

    override func setViewConfig() {
        guard let item = item else { return }
        let height: Int32 = Int32(item.images.original.height) ?? 0
        mainView.contentView.indicatorAction(bool: true)
        mainView.userImageView.setImageUrl(item.user.avatarURL)
        mainView.contentView.heightAnchor.constraint(equalToConstant: CGFloat(height)).isActive = true
        mainView.usernameLabel.text = item.user.name
        let gifURL = item.images.original.url
        DispatchQueue.main.async {
            self.mainView.contentView.imageView.image = UIImage.gifImageWithURL(gifURL)
            self.mainView.contentView.indicatorAction(bool: false)
        }
    }

    override func navigationItemConfig() {

        navigationItem.leftBarButtonItem = backBarButton
    }
}

