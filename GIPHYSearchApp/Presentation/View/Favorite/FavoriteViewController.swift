//
//  FavoriteViewController.swift
//  GIPHYSearchApp
//
//  Created by 박근보 on 2022/05/02.
//

import UIKit

final class FavoriteViewController: BaseViewController {

    private let mainView = FavoriteView()
    var viewModel: FavoriteViewModel?

    override func loadView() {
        self.view = mainView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
    }
}
