//
//  DependencyManager.swift
//  ExpenseTracker
//
//  Created by Avinash on 02/09/22.
//

import Foundation

typealias DependencyResolver = () -> AnyObject

protocol DependencyManager: AnyObject {
    
    /// Use this static method to register a dependency in the DI Container
    /// - Parameter type: type of dependency to be registered. Best practise is to register
    /// on protocol basis to have mock easiliy available
    /// - Parameter component: a closure returning the component object.
    /// It is only cache once it is resolved.
    ///
    
    static func register<Dependency>(_ type: Dependency.Type, component: @escaping DependencyResolver)
    
    /// Use this method to register a dependency in the DI Container
    /// - Parameter type: type of dependency to be registered. Best practise is to register
    /// on protocol basis to have mock easiliy available
    /// - Parameter component: a closure returning the component object.
    /// It is only cache once it is resolved.
    ///
    
    func register<Dependency>(_ type: Dependency.Type, component: @escaping DependencyResolver)
    
    
    /// Use this static method to resolve a dependency from the DI Container
    /// - Parameter type: type of dependency to be resolved.
    /// *NOTE*: It returns the item from cache if exists otherwise resolves
    /// the component closure and cache the dependency
    ///
    
    static func resolve<Dependency>(_ type: Dependency.Type) -> Dependency?
    
    
    /// Use this static method to resolve a dependency from the DI Container
    /// - Parameter type: type of dependency to be resolved.
    /// *NOTE*: It returns the item from cache if exists otherwise resolves
    /// the component closure and cache the dependency
    ///
    ///
    func resolve<Dependency>(_ type: Dependency.Type) -> Dependency?
}


final class DependencyManagerImp: DependencyManager {
    
    static let shared: DependencyManager = DependencyManagerImp()
    private var registry = [String: DependencyResolver]()
    private var cache = [String: WeakDependency]()
    
    private init() { }
    
    
    static func register<Dependency>(_ type: Dependency.Type,
                                     component: @escaping DependencyResolver) {
        DependencyManagerImp.shared.register(type, component: component)
    }
    
    func register<Dependency>(_ type: Dependency.Type,
                              component: @escaping DependencyResolver) {
        if registry.keys.contains(key(fromType: type)) {
            return
        }
        registry[key(fromType: type)] = component
    }
    
    static func resolve<Dependency>(_ type: Dependency.Type) -> Dependency? {
        return DependencyManagerImp.shared.resolve(type)
    }
    
    
    func resolve<Dependency>(_ type: Dependency.Type) -> Dependency? {
        /// check if dependency exists in the cache or not
        let key = key(fromType: type)
        if let dependency = cache[key] {
            return dependency.weakObject as? Dependency
        }
        
        /// if dependency is not found in the cache, resolve and keep a copy in cache
        if let resolver = registry[key] {
            let dependency = resolver()
            cache[key] = WeakDependency(dependency)
            return dependency as? Dependency
        }
        
        /// return nil otherwise
        return nil
    }
    
    private func key<Dependency>(fromType type: Dependency.Type) -> String {
        return "\(type)"
    }
}


struct WeakDependency {
    weak var weakObject: AnyObject?
    
    init(_ object: AnyObject) {
        self.weakObject = object
    }
}
