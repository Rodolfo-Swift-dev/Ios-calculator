//
//  CoinData.swift
//  Ios-calculatro
//
//  Created by rodoolfo gonzalez on 24-02-23.
//

import Foundation

struct CoinResponse : Decodable{
    
    let time : String?
    let assetIdBase : String?
    let assetIdQuote : String?
    let rate : Double?
    
    enum CodingKeys : String, CodingKey{
        case time,assetIdBase = "asset_id_base", assetIdQuote = "asset_id_quote", rate
        
    }
    
    /*time    "2023-02-28T16:17:52.0000000Z"
    asset_id_base    "BTC"
    asset_id_quote    "EUR"
    rate    22151.941883767155*/
}

