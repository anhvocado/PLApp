//
//  DetailRecommendItemsAPI.swift
//  PLAPP
//
//  Created by Nguyễn Thị Vân Anh on 02/06/2024.
//

import Foundation
import SwiftyJSON

class DetailRecommendItemsProductAPI: APIOperation<DetailRecommendItemsProductResponse> {
    init(id: Int) {
        super.init(request: APIRequest(name: "API recommend",
                                       baseURL: APIMainEnviroment().baseUrlV2,
                                       path: "recommend/\(id)",
                                       method: .get,
                                       parameters: .body([:])))
    }
}

struct DetailRecommendItemsProductResponse: APIResponseProtocol {
    var data: [DetailRecommendItemsProduct] = []
    init(json: JSON) {
        data = json["data"].arrayValue.map({DetailRecommendItemsProduct(json: $0)})
    }
}

struct DetailRecommendItemsProduct: Codable {
    let name: String?
    let productId: Int?
    
    init(json: JSON) {
        name = json["name"].string
        productId = json["id"].int

    }
}


