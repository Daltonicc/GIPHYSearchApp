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
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.placeholder = "Search GIPHY"
        textField.borderStyle = .none
        textField.textColor = .black
        textField.addLeftPadding()
        return textField
    }()
    let buttonView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.isUserInteractionEnabled = false
        return view
    }()
    let searchButton: UIButton = {
        let button = UIButton()
        button.tintColor = .white
        button.setImage(UIImage(systemName: "magnifyingglass"), for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
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

    override func setUpView() {

        self.backgroundColor = .white

        addSubview(textField)
        addSubview(buttonView)
        addSubview(searchButton)
    }

    override func setUpConstraint() {

        textField.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        textField.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
        textField.trailingAnchor.constraint(equalTo: searchButton.leadingAnchor).isActive = true
        textField.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true

        buttonView.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        buttonView.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
        buttonView.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        buttonView.widthAnchor.constraint(equalToConstant: 50).isActive = true

        searchButton.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        searchButton.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
        searchButton.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        searchButton.widthAnchor.constraint(equalToConstant: 50).isActive = true
    }
}
