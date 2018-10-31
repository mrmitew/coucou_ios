import Foundation

public protocol DiscoveryEvent {}

public extension DiscoveryEvent {
    public func toDisctionary() -> Dictionary<String, Any?> {
        let eventType: String
        
        if(self is ServiceResolved) {
            eventType = "ServiceResolved"
        } else if (self is ServiceLost) {
            eventType = "ServiceLost"
        } else if (self is DiscoveryFinished) {
            eventType = "DiscoveryFinished"
        } else if (self is ResolvingFinished) {
            eventType = "ResolvingFinished"
        } else if (self is DiscoveryFailure) {
            eventType = "DiscoveryFailure"
        } else {
            eventType = "unknown"
        }
        
        let service: DiscoveryService?
        
        if(self is ServiceResolved) {
            service = (self as! ServiceResolved).service
        } else if(self is ServiceLost) {
            service = (self as! ServiceLost).service
        } else {
            service = nil
        }
        
        return [
            "type": eventType,
            "service": service?.toDictionary()
        ]
    }
}

public struct ServiceResolved : DiscoveryEvent {
    public let service: DiscoveryService
}

public struct ServiceLost : DiscoveryEvent {
    public let service: DiscoveryService
}

public struct DiscoveryFinished : DiscoveryEvent {
    public let services: [NetService]
}

public struct ResolvingFinished : DiscoveryEvent {
    public let services: [DiscoveryService]
}

public struct DiscoveryFailure : DiscoveryEvent {
    let cause: String
}
