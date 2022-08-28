//
//  CategoryButtonView.swift
//  GIPHYSearchApp
//
//  Created by 박근보 on 2022/05/02.
//

import UIKit

enum CategoryStatus: Int {
    case gif
    case sticker
    case text
}

protocol CategoryButtonDelegate: AnyObject {
    func didTapCategoryButton()
}

final class CategoryButtonView: BaseView {

    let categoryStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        stackView.backgroundColor = UIColor(red: 59/255, green: 59/255, blue: 59/255, alpha: 1)
        return stackView
    }()
    let gifButton: UIButton = {
        let button = UIButton()
        button.setTitle("GIFs", for: .normal)
        button.setTitleColor(UIColor.white, for: .normal)
        button.titleLabel?.font = .boldSystemFont(ofSize: 20)
        button.layer.cornerRadius = 25
        button.tag = 0
        return button
    }()
    let stickerButton: UIButton = {
        let button = UIButton()
        button.setTitle("Stickers", for: .normal)
        button.setTitleColor(UIColor.white, for: .normal)
        button.titleLabel?.font = .boldSystemFont(ofSize: 20)
        button.layer.cornerRadius = 25
        button.tag = 1
        return button
    }()
    let textButton: UIButton = {
        let button = UIButton()
        button.setTitle("Text", for: .normal)
        button.setTitleColor(UIColor.white, for: .normal)
        button.titleLabel?.font = .boldSystemFont(ofSize: 20)
        button.layer.cornerRadius = 25
        button.tag = 2
        return button
    }()

    var status: CategoryStatus = .gif {
        didSet {
            configureStatus()
        }
    }

    weak var delegate: CategoryButtonDelegate?

    override init(frame: CGRect) {
        super.init(frame: frame)
        configureStatus()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }

    override func layout() {
        addSubview(categoryStackView)
        categoryStackView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            categoryStackView.topAnchor.constraint(equalTo: self.topAnchor),
            categoryStackView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            categoryStackView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            categoryStackView.bottomAnchor.constraint(equalTo: self.bottomAnchor)
        ])

        categoryStackView.addArrangedSubview(gifButton)
        categoryStackView.addArrangedSubview(stickerButton)
        categoryStackView.addArrangedSubview(textButton)
    }

    private func configureStatus() {
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

        gifButton.addTarget(self, action: #selector(buttonTap(sender:)), for: .touchUpInside)
        stickerButton.addTarget(self, action: #selector(buttonTap(sender:)), for: .touchUpInside)
        textButton.addTarget(self, action: #selector(buttonTap(sender:)), for: .touchUpInside)
    }

    @objc private func buttonTap(sender: UIButton) {
        status = CategoryStatus(rawValue: sender.tag) ?? .gif
        delegate?.didTapCategoryButton()
    }
}
