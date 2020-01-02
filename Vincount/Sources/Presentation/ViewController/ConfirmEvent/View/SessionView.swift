//
//  SessionView.swift
//  Vincount
//
//  Created by NguyenVanChien on 3/15/19.
//  Copyright © 2019 NguyenVanChien. All rights reserved.
//

import Foundation
import UIKit
import Reusable

class SessionView: UIView, NibOwnerLoadable {

    
    @IBOutlet weak var contentLabel: UILabel!
    
    convenience init() {
        let WIDTH_DEVICE = UIScreen.main.bounds.size.width
        let frame = CGRect(x: 0, y: 0, width: WIDTH_DEVICE, height: 30)
        self.init(frame: frame)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.initialize()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.initialize()
    }
    
    private func initialize() {
        self.loadNibContent()
    }
}
