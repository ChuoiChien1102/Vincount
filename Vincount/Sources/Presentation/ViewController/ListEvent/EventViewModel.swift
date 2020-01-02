//
//  EventViewModel.swift
//  Vincount
//
//  Created by NguyenVanChien on 3/14/19.
//  Copyright © 2019 NguyenVanChien. All rights reserved.
//

import Foundation
import RxSwift

class EventViewModel {
    
    typealias Dependency = EventDatabase
    private let eventDatabase: Dependency
    
    init(dependency: Dependency) {
        eventDatabase = dependency
    }
    
    func updateEvent(event: EventEntity, completion: () -> Void) {
        self.eventDatabase.updateEvent(event: event) {
            completion()
        }
    }
    
    func addEvent(event: EventEntity, completion: () -> Void) {
        self.eventDatabase.addEvent(event: event) {
            completion()
        }
    }
    
    func listEvent() -> Observable<[EventEntity]> {
        return self.eventDatabase.listEvent
    }
    
    func deleteEvent(id: String, completion: () -> Void) {
        self.eventDatabase.deleteEvent(id: id) {
            completion()
        }
    }
}

