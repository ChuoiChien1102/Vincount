//
//  Single+.swift
//  Vincount
//
//  Created by NguyenVanChien on 3/14/19.
//  Copyright © 2019 NguyenVanChien. All rights reserved.
//

import Foundation
import RxSwift

extension Single {
    static func empty() -> Single<Void> {
        return Single.just(1).map { _ in }
    }
}
