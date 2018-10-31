import Foundation

public protocol Logger {
    func d(tag: String, msg: String)
    func e(tag: String, msg: String)
}
