//
//  Api.swift
//  BraspagVerifyCard
//
//  Created by Jeferson Nazario on 10/08/20.
//  Copyright © 2020 jnazario.com. All rights reserved.
//

protocol ApiProtocol {
    func request<T: Decodable>(url: String,
                               method: String,
                               with parameters: [String: Any]?,
                               authenticationType: String,
                               completion: @escaping (T?, String?) -> Void)
}

@objc class Api: NSObject, ApiProtocol {
    
    static var shared: Api = {
       return Api()
    }()
    
    func request<T: Decodable>(url: String,
                               method: String,
                               with parameters: [String: Any]?,
                               authenticationType: String = "Basic",
                               completion: @escaping (T?, String?) -> Void) {
        let config: URLSessionConfiguration = URLSessionConfiguration.default
        let session: URLSession = URLSession(configuration: config)
        
        var urlRequest: URLRequest?
            urlRequest = URLRequest(url: URL(string: url)!)
        
        let credentials = parameters?["accesstoken"]
        let merchant = parameters?["merchantid"] as! String
        urlRequest?.allHTTPHeaderFields = ["Authorization": "Bearer \(credentials ?? "")", "MerchantId": merchant, "Content-Type": "application/json"]
        
        guard let hasRequest = parameters?["request"] as? VerifyCardRequest else {
            completion(nil, "É necessário informar os dados do cartão")
            return
        }
        
        let postData = try? JSONEncoder().encode(hasRequest)
        urlRequest?.httpBody = postData
        
        urlRequest?.httpMethod = "POST"
        
        if let myRequest = urlRequest {
            let task = session.dataTask(with: myRequest, completionHandler: { (result, _, error) in
                guard error == nil else {
                    completion(nil, "request error: " + error!.localizedDescription)
                    return
                }
                guard let data = result else {
                    completion(nil, "Nenhum dado retornado")
                    return
                }
                
                do {
                    let decoder = JSONDecoder()
                    decoder.keyDecodingStrategy = .convertFromUpperCamelCase
                    if authenticationType == "Basic" {
                        decoder.keyDecodingStrategy = .convertFromSnakeCase
                    }
                    
                    let decodableData: T = try decoder.decode(T.self, from: data)
                    
                    DispatchQueue.main.async {
                        completion(decodableData, nil)
                    }
                } catch let exception {
                    let resultString = String(data: data, encoding: .utf8) ?? "empty data"
                    completion(nil, "decode error: " + exception.localizedDescription + "\nResult: \(resultString)")
                }
            })
            
            task.resume()
        } else {
            completion(nil, "Não foi possível executar a chamada à API")
        }
    }
}
