//
//  CartListAPI.swift
//  PLAPP
//
//  Created by Nguyễn Thị Vân Anh on 01/06/2024.
//

import Foundation
import SwiftyJSON

class DeleteCartItem: APIOperation<DeleteCartItemResponse> {
    init(id: Int) {
        super.init(request: APIRequest(name: "API delete cart items",
                                       baseURL: APIMainEnviroment().baseUrl,
                                       path: "carts/\(id)",
                                       method: .delete,
                                       parameters: .body([:])))
    }
}

struct DeleteCartItemResponse: APIResponseProtocol {
    var statusCode: Int?
    var message: String?
    init(json: JSON) {
        statusCode = json["statusCode"].int
        message = json["message"].string
    }
}
