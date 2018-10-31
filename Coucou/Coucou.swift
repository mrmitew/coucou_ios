import Foundation

enum CoucouError: Error {
    case runtimeError(String)
}

public class Coucou: NSObject {
    private let driver: Driver
    private let logger: Logger?
    
    private init(driver: Driver, logger: Logger? = nil) {
        self.driver = driver
        self.logger = logger
    }
    
    public class Builder {
        private var driver: Driver? = nil
        private var logger: Logger? = nil
        
        public init() {
        }
        
        public func driver(_ driver: Driver) -> Builder {
            self.driver = driver
            return self
        }
        
        public func logger(_ logger: Logger) -> Builder {
            self.logger = logger
            return self
        }
        
        public func build() throws -> Coucou {
            if(driver == nil) {
                throw CoucouError.runtimeError("You need to provide a driver() to the builder")
            }
            return Coucou(driver: self.driver!, logger: self.logger)
        }
    }
    
    func startDiscovery(ofType type: String,
                     domain: String = "local.",
                     _ onResolved: @escaping (DiscoveryEvent) -> Void) -> Disposable {
        let discovery = driver.createDiscovery()
        discovery.discover(ofType: type, inDomain: domain, callback: onResolved)
        return discovery as Disposable
    }
    
    func startBroadcast() -> Disposable {
        // TODO
        return BroadcastDisposable()
    }
    
    private class BroadcastDisposable : Disposable {
        func dispose() {
            // TODO
        }
    }
}
