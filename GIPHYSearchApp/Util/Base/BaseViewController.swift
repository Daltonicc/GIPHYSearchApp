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
        barButton.image = UIImage(systemName: "chevron.left")
        barButton.tintColor = .white
        return barButton
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        configureView()

        backBarButton.target = self
        backBarButton.action = #selector(backButtonClicked)
    }

    func configureView() {}

    @objc func backButtonClicked() {
        navigationController?.popViewController(animated: true)
    }
}
