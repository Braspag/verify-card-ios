//
//  VerifyCardResponse.swift
//  BraspagVerifyCard
//
//  Created by Jeferson Nazario on 10/08/20.
//  Copyright © 2020 jnazario.com. All rights reserved.
//

public class VerifyCardResponse: NSObject, Codable {
    public var status: Int?
    public var providerReturnCode: String?
    public var providerReturnMessage: String?
    public var binData: BinData?
    
    public init(status: Int?, providerReturnCode: String?, providerReturnMessage: String?, binData: BinData?) {
        self.status = status
        self.providerReturnCode = providerReturnCode
        self.providerReturnMessage = providerReturnMessage
        self.binData = binData
    }
}

public class BinData: NSObject, Codable {
    public var provider: String?
    public var cardType: String?
    public var foreignCard: Bool?
    public var code: String?
    public var message: String?
    public var corporateCard: Bool?
    public var issuer: String?
    public var issuerCode: String?
    public var cardBin: String?
    public var lastFourDigits: String?
    
    public init(provider: String?,
         cardType: String?,
         foreignCard: Bool?,
         code: String?,
         message: String?,
         corporateCard: Bool?,
         issuer: String?,
         issuerCode: String?,
         cardBin: String?,
         lastFourDigits: String?) {
        
        self.provider = provider
        self.cardType = cardType
        self.foreignCard = foreignCard
        self.code = code
        self.message = message
        self.corporateCard = corporateCard
        self.issuer = issuer
        self.issuerCode = issuerCode
        self.cardBin = cardBin
        self.lastFourDigits = lastFourDigits
    }
}
