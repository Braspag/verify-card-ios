//
//  VerifyCardErrorResponse.swift
//  BraspagVerifyCard
//
//  Created by Jeferson Nazario on 10/08/20.
//  Copyright © 2020 jnazario.com. All rights reserved.
//

public class VerifyCardErrorResponse: NSObject, Codable {
    var code, message: String?
    
    init(code: String?, message: String?) {
        self.code = code
        self.message = message
    }
}
