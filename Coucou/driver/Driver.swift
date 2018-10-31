import Foundation

public protocol Driver {
    func getName() -> String
    func createDiscovery() -> DiscoveryEngine
    func createBroadcast() -> BroadcastEngine
}
