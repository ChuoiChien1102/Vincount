//
//  ViewModelAssembly.swift
//  Vincount
//
//  Created by NguyenVanChien on 3/14/19.
//  Copyright © 2019 NguyenVanChien. All rights reserved.
//

import Foundation
import Swinject

final class EventViewModelAssembly: Assembly {
    func assemble(container: Container) {
        container.register(EventViewModel.self) { resolver in
            let dependency = resolver.resolve(EventDatabase.self)!
            return EventViewModel(dependency: dependency)
        }
    }
}

final class PeopleViewModelAssembly: Assembly {
    func assemble(container: Container) {
        container.register(PeopleViewModel.self) { resolver in
            let dependency = resolver.resolve(PeopleDatabase.self)!
            return PeopleViewModel(dependency: dependency)
        }
    }
}

final class ExpensesViewModelAssembly: Assembly {
    func assemble(container: Container) {
        container.register(ExpensesViewModel.self) { resolver in
            let dependency = resolver.resolve(ExpensesDatabase.self)!
            return ExpensesViewModel(dependency: dependency)
        }
    }
}

final class ExpensesOfPeopleViewModelAssembly: Assembly {
    func assemble(container: Container) {
        container.register(ExpensesOfPeopleViewModel.self) { resolver in
            let dependency = resolver.resolve(ExpensesOfPeopleDatabase.self)!
            return ExpensesOfPeopleViewModel(dependency: dependency)
        }
    }
}
