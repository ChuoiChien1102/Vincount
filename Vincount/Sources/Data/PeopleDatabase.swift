//
//  PeopleDatabase.swift
//  Vincount
//
//  Created by ChuoiChien on 3/16/19.
//  Copyright © 2019 NguyenVanChien. All rights reserved.
//

import Foundation
import RealmSwift
import RxSwift
import RxRealm

protocol PeopleDatabase {
    func addPeople(people: PeopleEntity, completion: () -> Void)
    func updatePeople(people: PeopleEntity, completion: () -> Void)
    func deletePeople(id: String, completion: () -> Void)
    func listPeopleByEvent(owner: EventEntity) -> [PeopleEntity]
    func deletePeopleByEvent(event: EventEntity, completion: () -> Void)
}

class PeopleDatabaseImpl: PeopleDatabase {
    
    typealias Dependency = Realm
    private let realm: Realm
    init(dependency: Dependency) {
        realm = dependency
    }
    
    func listPeopleByEvent(owner: EventEntity) -> [PeopleEntity] {
        let objects = realm.objects(PeopleEntity.self).filter(NSPredicate(format: "owner == %@", owner))
        return objects.toArray()
    }
    
    func addPeople(people: PeopleEntity, completion: () -> Void) {
        try! realm.write(transaction: {
            realm.add(people, update: false)
        }, completion: {
            completion()
        })
    }
    
    func updatePeople(people: PeopleEntity, completion: () -> Void) {
        try! realm.write(transaction: {
            realm.add(people, update: true)
        }, completion: {
            completion()
        })
    }
    
    func deletePeople(id: String, completion: () -> Void) {
        try! realm.write(transaction: {
            realm.delete(realm.objects(PeopleEntity.self).filter("id == %@", id))
        }, completion: {
            completion()
        })
    }
    
    func deletePeopleByEvent(event: EventEntity, completion: () -> Void) {
        try! realm.write(transaction: {
            realm.delete(realm.objects(PeopleEntity.self).filter("owner == %@", event))
        }, completion: {
            completion()
        })
    }
}

