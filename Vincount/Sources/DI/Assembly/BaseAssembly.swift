//
//  BaseAssembly.swift
//  Vincount
//
//  Created by NguyenVanChien on 3/14/19.
//  Copyright © 2019 NguyenVanChien. All rights reserved.
//

import Foundation
import Swinject
import RealmSwift

final class RealmAssembly: Assembly {
    func assemble(container: Container) {
        container.register(Realm.self) { _ in
            // swiftlint:disable force_try
            try! Realm(configuration: Realm.Configuration(schemaVersion: 1))
            }
            .inObjectScope(.container)
    }
}

final class EventDatabaseAssembly: Assembly {
    func assemble(container: Container) {
        container.register(EventDatabase.self) { resolver in
            let dependency = resolver.resolve(Realm.self)!
            return EventDatabaseImpl(dependency: dependency)
        }
    }
}

final class PeopleDatabaseAssembly: Assembly {
    func assemble(container: Container) {
        container.register(PeopleDatabase.self) { resolver in
            let dependency = resolver.resolve(Realm.self)!
            return PeopleDatabaseImpl(dependency: dependency)
        }
    }
}

final class ExpensesDatabaseAssembly: Assembly {
    func assemble(container: Container) {
        container.register(ExpensesDatabase.self) { resolver in
            let dependency = resolver.resolve(Realm.self)!
            return ExpensesDatabaseImpl(dependency: dependency)
        }
    }
}

final class ExpensesOfPeopleDatabaseAssembly: Assembly {
    func assemble(container: Container) {
        container.register(ExpensesOfPeopleDatabase.self) { resolver in
            let dependency = resolver.resolve(Realm.self)!
            return ExpensesOfPeopleDatabaseImpl(dependency: dependency)
        }
    }
}
