//
//  CategoryButtonView.swift
//  GIPHYSearchApp
//
//  Created by 박근보 on 2022/05/02.
//

import UIKit

final class CategoryButtonView: BaseView {

    enum CategoryStatus {
        case gif
        case sticker
        case text
    }

    var status: CategoryStatus = .gif {
        didSet {
            statusConfig()
        }
    }

    let categoryStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        stackView.backgroundColor = UIColor(red: 59/255, green: 59/255, blue: 59/255, alpha: 1)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    let gifButton: UIButton = {
        let button = UIButton()
        button.setTitle("GIFs", for: .normal)
        button.setTitleColor(UIColor.white, for: .normal)
        button.layer.cornerRadius = 15
        return button
    }()
    let stickerButton: UIButton = {
        let button = UIButton()
        button.setTitle("Stickers", for: .normal)
        button.setTitleColor(UIColor.white, for: .normal)
        button.layer.cornerRadius = 15
        return button
    }()
    let textButton: UIButton = {
        let button = UIButton()
        button.setTitle("Text", for: .normal)
        button.setTitleColor(UIColor.white, for: .normal)
        button.layer.cornerRadius = 15
        return button
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        statusConfig()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }

    override func setUpView() {

        addSubview(categoryStackView)
        categoryStackView.addArrangedSubview(gifButton)
        categoryStackView.addArrangedSubview(stickerButton)
        categoryStackView.addArrangedSubview(textButton)

        gifButton.addTarget(self, action: #selector(gifButtonTap), for: .touchUpInside)
        stickerButton.addTarget(self, action: #selector(stickerButtonTap), for: .touchUpInside)
        textButton.addTarget(self, action: #selector(textButtonTap), for: .touchUpInside)
    }

    override func setUpConstraint() {

        categoryStackView.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        categoryStackView.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
        categoryStackView.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
        categoryStackView.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
    }

    private func statusConfig() {
        switch status {
        case .gif:
            gifButton.backgroundColor = .systemPurple
            stickerButton.backgroundColor = UIColor(red: 59/255, green: 59/255, blue: 59/255, alpha: 1)
            textButton.backgroundColor = UIColor(red: 59/255, green: 59/255, blue: 59/255, alpha: 1)
        case .sticker:
            stickerButton.backgroundColor = .systemGreen
            gifButton.backgroundColor = UIColor(red: 59/255, green: 59/255, blue: 59/255, alpha: 1)
            textButton.backgroundColor = UIColor(red: 59/255, green: 59/255, blue: 59/255, alpha: 1)
        case .text:
            textButton.backgroundColor = .systemPink
            stickerButton.backgroundColor = UIColor(red: 59/255, green: 59/255, blue: 59/255, alpha: 1)
            gifButton.backgroundColor = UIColor(red: 59/255, green: 59/255, blue: 59/255, alpha: 1)
        }
    }

    @objc private func gifButtonTap() {
        status = .gif
    }

    @objc private func stickerButtonTap() {
        status = .sticker
    }

    @objc private func textButtonTap() {
        status = .text
    }
}
