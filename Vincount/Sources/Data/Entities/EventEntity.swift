//
//  EventEntity.swift
//  Vincount
//
//  Created by NguyenVanChien on 3/14/19.
//  Copyright © 2019 NguyenVanChien. All rights reserved.
//

import Foundation
import RealmSwift

class EventEntity: Object {
    
    @objc dynamic var id: String = ""
    @objc dynamic var title: String = ""
    @objc dynamic var descript: String = ""
    let peoples = LinkingObjects(fromType: PeopleEntity.self, property: "owner")
    
    convenience init(id: String, title: String, descript: String) {
        self.init()
        self.id = id
        self.title = title
        self.descript = descript
    }
    
    override static func primaryKey() -> String? {
        return "id"
    }
}
