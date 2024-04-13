public protocol Destination { }

public protocol Router {
    func route(to destination: Destination)
}
