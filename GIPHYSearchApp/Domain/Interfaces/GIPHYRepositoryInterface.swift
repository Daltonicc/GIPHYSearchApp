//
//  GIPHYRepositoryInterface.swift
//  GIPHYSearchApp
//
//  Created by 박근보 on 2022/05/03.
//

import Foundation

protocol GIPHYRepositoryInterface {
    func getGiphyData(style: CategoryStatus,
                      query: String,
                      start: Int,
                      display: Int,
                      completion: @escaping (Result<GIFs, SearchError>) -> Void)
}
