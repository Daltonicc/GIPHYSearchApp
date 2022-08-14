//
//  GIPHYRepositoryInterface.swift
//  GIPHYSearchApp
//
//  Created by 박근보 on 2022/05/03.
//

import Foundation

protocol GIPHYRepositoryInterface {
    func requestGIFs(style: CategoryStatus, query: String, start: Int, display: Int) async throws -> GIFs
}
