//
//  EventDatabase.swift
//  Vincount
//
//  Created by NguyenVanChien on 3/14/19.
//  Copyright © 2019 NguyenVanChien. All rights reserved.
//

import Foundation
import RealmSwift
import RxSwift
import RxRealm

protocol EventDatabase {
    var listEvent: Observable<[EventEntity]> { get }
    func updateEvent(event: EventEntity, completion: () -> Void)
    func addEvent(event: EventEntity, completion: () -> Void)
    func deleteEvent(id: String, completion: () -> Void)
}

class EventDatabaseImpl: EventDatabase {
    
    typealias Dependency = Realm
    private let realm: Realm
    init(dependency: Dependency) {
        realm = dependency
    }
    
    var listEvent: Observable<[EventEntity]> {
        return Observable.changeset(from: realm.objects(EventEntity.self)).map({ (result, _ ) -> [EventEntity] in
            return result.toArray()
        })
    }
    
    func updateEvent(event: EventEntity, completion: () -> Void) {
        try! realm.write(transaction: {
            realm.add(event, update: true)
        }, completion: {
            completion()
        })
    }
    
    func addEvent(event: EventEntity, completion: () -> Void) {
        try! realm.write(transaction: {
            realm.add(event, update: false)
        }, completion: {
            completion()
        })
    }
    
    func deleteEvent(id: String, completion: () -> Void) {
        try! realm.write(transaction: {
            realm.delete(realm.objects(EventEntity.self).filter("id == %@", id))
        }, completion: {
            completion()
        })
    }
    
}

