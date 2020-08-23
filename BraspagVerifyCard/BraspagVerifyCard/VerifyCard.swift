//
//  VerifyCard.swift
//  BraspagVerifyCard
//
//  Created by Jeferson Nazario on 10/08/20.
//  Copyright © 2020 jnazario.com. All rights reserved.
//

import BraspagOAuth

public protocol VerifyCardProtocol: NSObject {
    func verify(request: VerifyCardRequest, onCompletion: @escaping (VerifyCardResult<VerifyCardResponse>) -> Void)
}

public class VerifyCard: NSObject {
    var accessToken, merchantId, clientId, clientSecret: String
    var environment: Environment
    
    private var credentialClient: HttpCredentialsClient?
    private let authenticateErrorMessage: String = "Não foi possível autenticar."
    
    init(accessToken: String, merchantId: String, clientId: String, clientSecret: String, environment: Environment = .sandbox) {
        self.accessToken = accessToken
        self.merchantId = merchantId
        self.environment = environment
        self.clientId = clientId
        self.clientSecret = clientSecret
    }
    
    public static func instantiate(accessToken: String, merchantId: String, clientId: String, clientSecret: String, environment: Environment = .sandbox) -> VerifyCard {
        return VerifyCard(accessToken: accessToken, merchantId: merchantId, clientId: clientId, clientSecret: clientSecret, environment: environment)
    }
    
    public func verify(request: VerifyCardRequest, onCompletion: @escaping (VerifyCardResult<VerifyCardResponse>) -> Void) {
        Api.shared.request(url: getUrl(), method: "POST", with: ["": ""]) { (result: VerifyCardResult<VerifyCardResponse>?, error) in
            guard error == nil else {
                onCompletion(VerifyCardResult(result: nil, statusCode: 0, errors: [VerifyCardErrorResponse(code: nil, message: error!)]))
                return
            }
            
            guard let data = result else {
                onCompletion(VerifyCardResult(result: nil, statusCode: -1, errors: [VerifyCardErrorResponse(code: nil, message: "Nenhum resultado obtido")]))
                return
            }
            
            onCompletion(data)
        }
    }
    
    private func getUrl() -> String {
        return environment == .sandbox ? "https://apisandbox.braspag.com.br/v2/" : "https://api.braspag.com.br/v2/"
        
    }
    
    private func authenticate(completion: @escaping (String?, String?) -> Void) {
        credentialClient?.getOAuthCredentials {[weak self] (accessToken, error) in
            guard error == nil else {
                completion(nil, error)
                return
            }
            
            guard let token = accessToken else {
                completion(nil, self?.authenticateErrorMessage)
                return
            }
            
            completion(token.token, nil)
        }
    }
}
