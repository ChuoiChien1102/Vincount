//
//  Applicable+.swift
//  Vincount
//
//  Created by NguyenVanChien on 3/14/19.
//  Copyright © 2019 NguyenVanChien. All rights reserved.
//

import Foundation

public protocol Applicable {}

public extension Applicable {
    
    @discardableResult
    func apply(_ closure: (Self) -> Void) -> Self {
        closure(self)
        return self
    }
}

extension NSObject: Applicable {}

