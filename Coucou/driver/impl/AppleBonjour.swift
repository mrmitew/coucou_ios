import Foundation

public class AppleBonjour : Driver {
    public init() {}
    
    public func getName() -> String {
        return "Apple Bonjour"
    }
    
    public func createBroadcast() -> BroadcastEngine {
        return AppleBroadcast()
    }
    
    public func createDiscovery() -> DiscoveryEngine {
        return AppleDiscovery()
    }
}
