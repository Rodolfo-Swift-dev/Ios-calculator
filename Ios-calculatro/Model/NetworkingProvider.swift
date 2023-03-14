//
//  NetworkingProvider.swift
//  Ios-calculatro
//
//  Created by rodoolfo gonzalez on 23-02-23.
//

import Foundation
import Alamofire

final class NetworkingProvider{
    //standard en Swift
    static let shared = NetworkingProvider()
    private let kBaseUrl = "https://rest.coinapi.io/v1/exchangerate/BTC/USD?apikey=ED52E90D-AC17-4F76-83C8-8C67E8C19B2B"
    private let kStatusOk = 200...299
    
    
    
    func getCoin(success : @escaping(_ coinResponse: CoinResponse)-> (), failure : @escaping(_ error: Error?)-> () ){
        
        let url = kBaseUrl
        
        AF.request(url, method: .get).validate(statusCode: kStatusOk ).responseDecodable (of: CoinResponse.self ) { response in
            if let coinResponse = response.value{
                success(coinResponse)
                
            }else{
                failure(response.error)
            }
            
        }
        
    }
}
