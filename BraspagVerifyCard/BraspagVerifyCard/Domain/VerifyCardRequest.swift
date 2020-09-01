//
//  VerifyCardRequest.swift
//  BraspagVerifyCard
//
//  Created by Jeferson Nazario on 03/08/20.
//  Copyright © 2020 jnazario.com. All rights reserved.
//

public class VerifyCardRequest: NSObject, Codable {
    var provider: String?
    var card: Card?
    
    public init(provider: String?, card: Card?) {
        self.provider = provider
        self.card = card
    }
}

public class Card: NSObject, Codable {
    var cardNumber: String?
    var holder: String?
    var expirationDate: String?
    var securityCode: String?
    var brand: String?
    var type: CardType?
    
    public init(cardNumber: String?,
         holder: String?,
         expirationDate: String?,
         securityCode: String?,
         brand: String?,
         type: CardType?) {
        self.cardNumber = cardNumber
        self.holder = holder
        self.expirationDate = expirationDate
        self.securityCode = securityCode
        self.brand = brand
        self.type = type
    }
}

public enum CardType: String {
    case DebitCard
    case CreditCard
}

extension CardType: Codable {
    public init(from decoder: Decoder) throws {
        self = try CardType(rawValue: decoder.singleValueContainer().decode(RawValue.self)) ?? .DebitCard
    }
}
