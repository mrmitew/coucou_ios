import Foundation

public class StandardLogger : Logger {
    public init() {}
    
    public func d(tag: String, msg: String) {
        print("D: [\(tag)]: \(msg)")
    }
    
    public func e(tag: String, msg: String) {
        print("E: [\(tag)]: \(msg)")
    }
}
