//
//  PeopleViewModel.swift
//  Vincount
//
//  Created by ChuoiChien on 3/16/19.
//  Copyright © 2019 NguyenVanChien. All rights reserved.
//

import Foundation
import RxSwift

class PeopleViewModel {
    
    typealias Dependency = PeopleDatabase
    private let peopleDatabase: Dependency
    
    init(dependency: Dependency) {
        peopleDatabase = dependency
    }
    
    func addPeople(people: PeopleEntity, completion: () -> Void) {
        self.peopleDatabase.addPeople(people: people) {
            completion()
        }
    }
    
    func updatePeople(people: PeopleEntity, completion: () -> Void) {
        self.peopleDatabase.updatePeople(people: people) {
            completion()
        }
    }
    
    func listPeopleByEvent(owner: EventEntity) -> [PeopleEntity] {
        return self.peopleDatabase.listPeopleByEvent(owner: owner)
    }
    
    func deletePeople(id: String, completion: () -> Void) {
        self.peopleDatabase.deletePeople(id: id) {
            completion()
        }
    }
    
    func deletePeopleByEvent(event: EventEntity, completion: () -> Void) {
        self.peopleDatabase.deletePeopleByEvent(event:event) {
            completion()
        }
    }
}

