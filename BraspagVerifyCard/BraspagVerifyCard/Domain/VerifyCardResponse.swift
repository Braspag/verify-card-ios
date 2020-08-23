//
//  VerifyCardResponse.swift
//  BraspagVerifyCard
//
//  Created by Jeferson Nazario on 10/08/20.
//  Copyright © 2020 jnazario.com. All rights reserved.
//

public class VerifyCardResponse: NSObject, Codable {
    var status: Int?
    var providerReturnCode: String?
    var providerReturnMessage: String?
    var binData: BinData?
    
    init(status: Int?, providerReturnCode: String?, providerReturnMessage: String?, binData: BinData?) {
        self.status = status
        self.providerReturnCode = providerReturnCode
        self.providerReturnMessage = providerReturnMessage
        self.binData = binData
    }
}

public class BinData: NSObject, Codable {
    var provider: String?
    var cardType: String?
    var foreignCard: Bool?
    var code: String?
    var message: String?
    var corporateCard: Bool?
    var issuer: String?
    var issuerCode: String?
    var cardBin: String?
    var lastFourDigits: String?
    
    init(provider: String?,
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
