//
//  BaseViewController.swift
//  GIPHYSearchApp
//
//  Created by 박근보 on 2022/05/02.
//

import UIKit

class BaseViewController: UIViewController {

    let backBarButton: UIBarButtonItem = {
        let barButton = UIBarButtonItem()
        barButton.image = UIImage(systemName: "arrow.left")
        barButton.tintColor = .black
        return barButton
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        setViewConfig()
        navigationItemConfig()
    }

    func setViewConfig() {
        view.backgroundColor = .white
    }

    func navigationItemConfig() {}
}
