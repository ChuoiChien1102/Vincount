//
//  PeopleEntity.swift
//  Vincount
//
//  Created by NguyenVanChien on 3/14/19.
//  Copyright © 2019 NguyenVanChien. All rights reserved.
//

import Foundation
import RealmSwift

class PeopleEntity: Object {
    
    @objc dynamic var id: String = ""
    @objc dynamic var name: String = ""
    @objc dynamic var balance: Int = 0
    @objc dynamic var owner:  EventEntity?
    let expensesOfPeoples = LinkingObjects(fromType: ExpenseOfPeopleEntity.self, property: "peopleOwner")
    
    convenience init(id: String, name: String, balance: Int, owner: EventEntity?) {
        self.init()
        self.id = id
        self.name = name
        self.balance = balance
        self.owner = owner
    }
    
    override static func primaryKey() -> String? {
        return "id"
    }
}

