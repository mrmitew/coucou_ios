import Foundation

public class AppleBonjour : NSObject, Driver {
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
