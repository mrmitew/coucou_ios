import Foundation

public protocol BroadcastEngine : Engine {
    func broadcast(withConfig config: BroadcastConfig)
}
