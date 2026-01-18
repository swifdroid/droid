public protocol AnyIdentable {
    func identHash() -> Int
}

public protocol Identable: Hashable, AnyIdentable {
    associatedtype ID: Hashable
    
    typealias IDKey = KeyPath<Self, ID>
    
    static var idKey: IDKey { get }
}

extension String: AnyIdentable {
    public func identHash() -> Int { hashValue }
}

extension Identable {
    public func hash(into hasher: inout Hasher) {
        hasher.combine(self[keyPath: Self.idKey])
    }
	
	public static func == (lhs: Self, rhs: Self) -> Bool {
		lhs.identHash() == rhs.identHash()
	}
    
    public func identHash() -> Int {
        self[keyPath: Self.idKey].hashValue 
    }
}
