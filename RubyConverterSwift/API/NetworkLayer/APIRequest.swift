//
//  APIRequest.swift
//  RubyConverterSwift
//
//  Created by Chan, Paul | Paul | PAYSD on 2019/05/23.
//  Copyright © 2019年 Chan Ka Ho, Paul. All rights reserved.
//

import Foundation
import Alamofire

enum APIResult<T> {
    case success(T)
    case failure(Error)
}

protocol APIRequest {
    var baseUrl: String { get }
    var path: String { get }
    var httpMethod: HTTPMethod { get }
    var parameters: [String : Any]? { get }
    var headers: [String : String]? { get }
    var bodyEncoding: ParameterEncoding { get }
}
