import Foundation

/// dummy implementaition of DIContainer. For demo purposes. With no Graphs support or Transient Graph Style of 
public class Container {
    enum Error: Swift.Error {
        case registrationNotFound
    }
    
    class Registration {
        var factory: (Container) -> Any
        var meta: Any.Type
        
        init(factory: @escaping (Container) -> Any, meta: Any.Type) {
            self.factory = factory
            self.meta = meta
        }
        
        func isKind<T>(of type: T.Type) -> Bool {
            return meta is T.Type
        }
    }
    
    var registry: [Registration] = []
    let lock = NSRecursiveLock()
    
    public func register<T>(_ type: T.Type, factory: @escaping (Container) -> T) {
        let registration = Registration(factory: factory, meta: type)
        
        lock.lock()
        registry.removeAll { $0.isKind(of: type) }
        registry.append(registration)
        lock.unlock()
    }
    
    /// Reset all registration
    public func reset() {
        lock.lock()
        registry = []
        lock.unlock()
    }
    
    /// Safe argumentless resolve.
    /// @Discussion
    ///  The type should be inferred outside like this:
    /// ```swift
    /// let object: MyType = container.resolve()
    /// ```
    public func resolve<T>() -> T? {
        defer {
            lock.unlock()
        }
        lock.lock()
        return registry.first { $0.isKind(of: T.self) }?.factory(self) as? T
    }
    
    /// Try - catch varient for safe resolving.
    public func tryResolve<T>() throws -> T {
        let object: T? = resolve()
        guard let object else {
            throw Error.registrationNotFound
        }
        return object
    }
    
    /// - Parameter type:Return type of registration
    /// - Returns: Returns object if registered
    public func resolve<T>(_ type: T.Type) -> T? {
        return resolve()
    }
}
