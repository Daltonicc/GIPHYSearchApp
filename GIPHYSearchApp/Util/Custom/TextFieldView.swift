//
//  TextFieldView.swift
//  GIPHYSearchApp
//
//  Created by 박근보 on 2022/05/02.
//

import UIKit

final class TextFieldView: BaseView {

    let textField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Search GIPHY"
        textField.borderStyle = .none
        textField.textColor = .black
        textField.addLeftPadding()
        return textField
    }()
    let buttonView: UIView = {
        let view = UIView()
        view.isUserInteractionEnabled = false
        return view
    }()
    let searchButton: UIButton = {
        let button = UIButton()
        button.tintColor = .white
        button.setImage(UIImage(systemName: "magnifyingglass"), for: .normal)
        button.contentVerticalAlignment = .fill
        button.contentHorizontalAlignment = .fill
        button.imageEdgeInsets = UIEdgeInsets(top: 5, left: 3, bottom: 5, right: 5)
        return button
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }

    override func layout() {
        self.backgroundColor = .white
        
        addSubview(buttonView)
        buttonView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            buttonView.topAnchor.constraint(equalTo: self.topAnchor),
            buttonView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            buttonView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            buttonView.widthAnchor.constraint(equalToConstant: 50)
        ])

        addSubview(searchButton)
        searchButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            searchButton.topAnchor.constraint(equalTo: self.topAnchor),
            searchButton.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            searchButton.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            searchButton.widthAnchor.constraint(equalToConstant: 50)
        ])

        addSubview(textField)
        textField.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            textField.topAnchor.constraint(equalTo: self.topAnchor),
            textField.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            textField.trailingAnchor.constraint(equalTo: searchButton.leadingAnchor),
            textField.bottomAnchor.constraint(equalTo: self.bottomAnchor)
        ])
    }
}
