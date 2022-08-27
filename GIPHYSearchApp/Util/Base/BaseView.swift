//
//  BaseView.swift
//  GIPHYSearchApp
//
//  Created by 박근보 on 2022/05/02.
//

import UIKit

class BaseView: UIView, ViewRepresentable {

    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
        layout()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }

    func layout() {}
}
