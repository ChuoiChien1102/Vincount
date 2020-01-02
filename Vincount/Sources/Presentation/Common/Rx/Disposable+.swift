//
//  Disposable+.swift
//  Vincount
//
//  Created by NguyenVanChien on 3/14/19.
//  Copyright © 2019 NguyenVanChien. All rights reserved.
//

import Foundation
import RxSwift

extension Disposable {
    
    @discardableResult
    func addTo(_ compositeDisposable:inout CompositeDisposable) -> Disposable {
        if compositeDisposable.isDisposed {
            compositeDisposable = CompositeDisposable()
        }
        _ = compositeDisposable.insert(self)
        return self
    }
}

