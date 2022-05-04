//
//  ImageCacheManager.swift
//  GIPHYSearchApp
//
//  Created by 박근보 on 2022/05/03.
//

import UIKit

final class ImageCacheManager {

    static let shared = NSCache<NSString, UIImage>()

    private init() {}
}
