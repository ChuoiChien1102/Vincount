//
//  Observable+.swift
//  Vincount
//
//  Created by NguyenVanChien on 3/14/19.
//  Copyright © 2019 NguyenVanChien. All rights reserved.
//

import Foundation
import RxSwift

extension Observable {
    func subscribeBy(onNext: ((Element) -> Void)? = nil, onComplete: (() -> Void)? = nil, onError: ((Error) -> Void)? = nil) -> Disposable {
        return subscribe { event in
            switch event {
            case .next(let element):
                onNext?(element)
            case .completed:
                onComplete?()
            case .error(let error):
                onError?(error)
            }
        }
    }
}

