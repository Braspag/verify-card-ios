//
//  Environment.swift
//  BraspagVerifyCard
//
//  Created by Jeferson Nazario on 10/08/20.
//  Copyright © 2020 jnazario.com. All rights reserved.
//

public enum Environment: String {
    case sandbox
    case production
}

extension Environment: Codable {
    public init(from decoder: Decoder) throws {
        self = try Environment(rawValue: decoder.singleValueContainer().decode(RawValue.self)) ?? .production
    }
}
