// Copyright 2023 Skip
//
// This is free software: you can redistribute and/or modify it
// under the terms of the GNU Lesser General Public License 3.0
// as published by the Free Software Foundation https://fsf.org

#if SKIP
public typealias CGFloat = Double

public struct CGPoint: Hashable {
    public static let zero = CGPoint()
    public var x: Double
    public var y: Double

    public init(x: Double = 0.0, y: Double = 0.0) {
        self.x = x
        self.y = y
    }
}

public struct CGSize: Hashable {
    public static let zero = CGSize()
    public var width: Double
    public var height: Double

    public init(width: Double = 0.0, height: Double = 0.0) {
        self.width = width
        self.height = height
    }
}

public struct CGRect: Hashable {
    public static let zero = CGRect()
    public var origin: CGPoint
    public var size: CGSize

    public init(origin: CGPoint = .zero, size: CGSize = .zero) {
        self.origin = origin
        self.size = size
    }

    public init(x: Double, y: Double, width: Double, height: Double) {
        self.init(origin: CGPoint(x: x, y: y), size: CGSize(width: width, height: height))
    }
}
#endif
