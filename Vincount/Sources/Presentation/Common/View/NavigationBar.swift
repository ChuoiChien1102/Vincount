//
//  NavigationBar.swift
//  Vincount
//
//  Created by NguyenVanChien on 3/14/19.
//  Copyright © 2019 NguyenVanChien. All rights reserved.
//

import UIKit

class NavigationBar: UINavigationBar {
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupNavigationBarAppearance()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupNavigationBarAppearance()
    }
    
    private func setupNavigationBarAppearance() {
        self.isTranslucent = false
        self.barTintColor = UIColor.init(named: .mainBlue)
        self.tintColor = UIColor.white
        
        let attrs = [
            NSAttributedString.Key.foregroundColor: UIColor.white,
            NSAttributedString.Key.font: UIFont(name: "Helvetica-Bold", size: 18.0)!
        ]
        UINavigationBar.appearance().titleTextAttributes = attrs
        UIBarButtonItem.appearance().setTitleTextAttributes(attrs, for: .normal)
        UIBarButtonItem.appearance().setTitleTextAttributes(attrs, for: .highlighted)
        
        // set image for backItem
        let  backButtonImage = UIImage(named: "ic_back")
        UINavigationBar.appearance().backIndicatorImage = backButtonImage
        UINavigationBar.appearance().backIndicatorTransitionMaskImage = backButtonImage
    }
    
    // hidden backItem default
    override func layoutSubviews() {
        topItem?.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        super.layoutSubviews()
    }
}

