//
//  VerifyCardResult.swift
//  BraspagVerifyCard
//
//  Created by Jeferson Nazario on 10/08/20.
//  Copyright © 2020 jnazario.com. All rights reserved.
//

public class VerifyCardResult<T: Codable>: NSObject, Codable {
    public var result: T?
    public var statusCode: Int
    public var errors: [VerifyCardErrorResponse]?
    
    public init(result: T?, statusCode: Int, errors: [VerifyCardErrorResponse]?) {
        self.result = result
        self.statusCode = statusCode
        self.errors = errors
    }
}
