//
//  Observable.swift
//  GIPHYSearchApp
//
//  Created by 박근보 on 2022/05/03.
//

import Foundation

class Observable<T> {

    private var listener: ( (T) -> Void )?

    var value: T {
        didSet {
            listener?(value)
        }
    }

    init(_ value: T) {
        self.value = value
    }

    func bind(_ closure: @escaping (T) -> Void) {
        closure(value)

        listener = closure
    }
}
