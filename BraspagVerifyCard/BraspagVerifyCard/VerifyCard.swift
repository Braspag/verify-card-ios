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

public class VerifyCard: NSObject, VerifyCardProtocol {
    var merchantId, clientId, clientSecret: String
    var environment: Environment
    
    private var credentialClient: HttpCredentialsClient?
    private let authenticateErrorMessage: String = "Não foi possível autenticar."
    
    init(merchantId: String, clientId: String, clientSecret: String, environment: Environment = .sandbox) {
        self.merchantId = merchantId
        self.environment = environment
        self.clientId = clientId
        self.clientSecret = clientSecret
        
        var oAuthEnv = BraspagOAuth.Environment.production
        if environment == .sandbox {
            oAuthEnv = BraspagOAuth.Environment.sandbox
        }
        
        credentialClient = HttpCredentialsClient(clientId: clientId,
                                                 clientSecret: clientSecret,
                                                 environment: oAuthEnv)
    }
    
    public static func instantiate(merchantId: String, clientId: String, clientSecret: String, environment: Environment = .sandbox) -> VerifyCardProtocol {
        return VerifyCard(merchantId: merchantId, clientId: clientId, clientSecret: clientSecret, environment: environment)
    }
    
    public func verify(request: VerifyCardRequest, onCompletion: @escaping (VerifyCardResult<VerifyCardResponse>) -> Void) {
        authenticate { (authToken, error) in
            guard error == nil else {
                onCompletion(VerifyCardResult(result: nil, statusCode: 0, errors: [VerifyCardErrorResponse(code: nil, message: error!)]))
                return
            }
            
            guard let token = authToken else {
                onCompletion(VerifyCardResult(result: nil, statusCode: 0, errors: [VerifyCardErrorResponse(code: nil, message: self.authenticateErrorMessage)]))
                return
            }
            let params: [String: Any] = ["accesstoken": token, "merchantid": self.merchantId, "request": request]
            Api.shared.request(url: self.getUrl(), method: "POST", with: params) { (result: VerifyCardResult<VerifyCardResponse>?, error) in
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
