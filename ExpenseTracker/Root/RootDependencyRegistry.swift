//
//  RootDependencyRegistry.swift
//  ExpenseTracker
//
//  Created by Avinash on 02/09/22.
//

import Foundation

/// `RootDependencyRegistry` serves as app wide dependency registry.
/// This can be used register and resolve the dependency
/// It caches the dependencies which can be shared
///

protocol RootDependencyRegistry {
    
    /// use this method to register the dependencies
    /// best place to call would be app:didFinishLaunchingWithOptions:
    /// 
    
    func registerDependencies()
}


struct RootDependencyRegistryImp: RootDependencyRegistry {
    
    private let dependencyManager: DependencyManager
    
    init() {
        self.dependencyManager = DependencyManagerImp.shared
    }
    
    func registerDependencies() {
        
        /// database manager
        dependencyManager.register(DatabaseManager.self) {
            return DatabaseManagerImp.shared
        }
        
        /// logger
        dependencyManager.register(Logger.self) {
            #if DEBUG
                return DebugLogger()
            #else
                return ProdLogger()
            #endif
        }
    }
    
}
