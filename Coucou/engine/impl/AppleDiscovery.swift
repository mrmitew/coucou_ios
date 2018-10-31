import Foundation

public class AppleDiscovery : DiscoveryEngine {
    private let timeout: TimeInterval = 10.0
    
    private let logger: Logger?
    private let serviceBrowser: NetServiceBrowser
    
    private var serviceTimeout: Timer = Timer()
    private var listener: DiscoveryListener? = nil
    
    init(logger: Logger? = nil) {
        self.logger = logger
        self.serviceBrowser = NetServiceBrowser()
    }
    
    func discover(ofType type: String,
                  inDomain domain: String,
                  callback: @escaping (DiscoveryEvent) -> Void) {
        serviceTimeout = Timer.scheduledTimer(
            timeInterval: self.timeout,
            target: self,
            selector: #selector(noServicesFound),
            userInfo: nil,
            repeats: false)
        
        let discoveryFinishedCallback: () -> Void = {
            self.serviceBrowser.stop()
        }
        
        self.listener = DiscoveryListener(logger: logger,
                                          serviceTimeout: serviceTimeout,
                                          onDiscoveryFinished: discoveryFinishedCallback,
                                          callback)
        serviceBrowser.delegate = self.listener
        
        serviceBrowser.searchForServices(ofType: type, inDomain: domain)
    }
    
    func dispose() {
        self.serviceBrowser.stop()
        self.listener?.dispose()
        self.listener = nil
    }
    
    @objc
    func noServicesFound() {
        self.listener?.timeout()
    }
    
    /**
     * Discovery listener
     */
    
    private class DiscoveryListener : NSObject, NetServiceBrowserDelegate, Disposable {
        private var services: [NetService]
        private let logger: Logger?
        private let callback: (DiscoveryEvent) -> Void
        private let discoveryFinishedCallback: () -> Void
        private let backlog: ServiceResolveBacklog
        private let timeoutTimer: Timer
        
        init(logger: Logger?,
             serviceTimeout timeoutTimer: Timer,
             onDiscoveryFinished discoveryFinishedCallback: @escaping () -> Void,
             _ callback: @escaping (DiscoveryEvent) -> Void) {
            self.timeoutTimer = timeoutTimer
            self.discoveryFinishedCallback = discoveryFinishedCallback
            self.callback = callback
            self.logger = logger
            self.backlog = ServiceResolveBacklog(logger: logger, callback)
            self.services = [NetService]()
            
        }
        
        public func timeout() {
            if backlog.servicesBeingResolved() == 0 && services.count == 0 {
                let cause = "No services found"
                self.callback(DiscoveryFailure(cause: cause))
                dispose()
            }
        }
        
        public func dispose() {
            backlog.dispose()
            services.removeAll()
        }
        
        public func netServiceBrowser(_ browser: NetServiceBrowser,
                                      didNotSearch errorDict: [String : NSNumber]) {
            logger?.d(tag: "Coucou", msg: "\(errorDict)")
        }
        
        public func netServiceBrowser(_ browser: NetServiceBrowser,
                                      didFind service: NetService,
                                      moreComing: Bool) {
            timeoutTimer.invalidate()
            service.delegate = self.backlog
            services.append(service)
            
            self.backlog.queue(service: service, withTimeout: timeoutTimer.timeInterval)
            
            logger?.d(tag: "Coucou", msg: "Found: \(String(describing: service)). More to come? \(moreComing)")
            
            if !moreComing {
                self.callback(DiscoveryFinished(services: services))
                self.discoveryFinishedCallback()
            }
        }
        
        /**
         * Backlog for resolving services
         */
        
        private class ServiceResolveBacklog : NSObject, NetServiceDelegate, Disposable {
            private let logger: Logger?
            private var services = [NetService]()
            
            private let callback: (DiscoveryEvent) -> Void
            
            init(logger: Logger?, _ callback: @escaping (DiscoveryEvent) -> Void) {
                self.callback = callback
                self.logger = logger
            }
            
            public func queue(service: NetService, withTimeout timeout: Double) {
                service.resolve(withTimeout: timeout)
            }
            
            public func servicesBeingResolved() -> Int {
                return services.count
            }
            
            public func dispose() {
                services.removeAll()
            }
            
            public func netService(_ sender: NetService,
                                   didUpdateTXTRecord data: Data) {
                logger?.d(tag: "Coucou", msg: "\(data)")
            }
            
            public func netService(_ sender: NetService,
                                   didNotResolve errorDict: [String : NSNumber]) {
                removeServiceFromResolveQueue(service: sender)
                logger?.d(tag: "Coucou", msg: "\(errorDict)")
            }
            
            public func netServiceWillResolve(_ sender: NetService) {
                logger?.d(tag: "Coucou", msg: "To resolve \(String(describing: sender))")
                services.append(sender)
            }
            
            public func netServiceDidResolveAddress(_ sender: NetService) {
                logger?.d(tag: "Coucou", msg: "Service resolved: \(sender)")
                self.callback(ServiceResolved(service: sender.toDiscoveryService()))
                removeServiceFromResolveQueue(service: sender)
            }
            
            func removeServiceFromResolveQueue(service: NetService) {
                if let serviceIndex = services.index(of: service) {
                    services.remove(at: serviceIndex)
                }
                
                if services.count == 0 {
                    self.callback(ResolvingFinished(services: services.map { (service) -> DiscoveryService in
                        return service.toDiscoveryService()
                    }))
                } else {
                    logger?.d(tag: "Coucou", msg: "[\(services.count)] services to resolve left")
                }
            }
        }
    }
}

