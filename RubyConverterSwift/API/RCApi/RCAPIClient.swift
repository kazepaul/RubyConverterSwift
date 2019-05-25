//
//  RCAPIRequest.swift
//  RubyConverterSwift
//
//  Created by Chan, Paul | Paul | PAYSD on 2019/05/23.
//  Copyright © 2019年 Chan Ka Ho, Paul. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyXMLParser

fileprivate let AppID = "dj00aiZpPUcyNlBSb2UzWDRyQSZzPWNvbnN1bWVyc2VjcmV0Jng9OTU-"

enum NetworkError: String, Error {
    case badRequest = "Bad request"
    case unauthorized = "Unauthorized"
    case forbidden = "Forbidden"
    case notFound = "Not Found"
    case internalServerError = "Internal Server Error"
    case serviceUnavailable = "Service unavailable"
    case networkRequestFail = "Network Request Fail"

}

struct RCAPIClient: APIRequest {
    var baseUrl: String {
        return "https://jlp.yahooapis.jp"
    }
    
    var path: String {
        return "/FuriganaService/V1/furigana"
    }
    
    var httpMethod: HTTPMethod {
        return .get
    }
    
    var parameters: [String : Any]? {
        var para = ["appid" : AppID,
                    "sentence" : sentence]
        if 1...8 ~= grade {
            para["grade"] = String(grade)
        }
        return para
    }
    
    var headers: [String : String]? = nil
    
    var bodyEncoding: ParameterEncoding {
        return URLEncoding.queryString
    }
    
    var sentence: String
    var grade: Int
    
    init(sentence: String, grade: Int) {
        self.sentence = sentence
        self.grade = grade
    }
    
    func requestForRubyConvert(completion: @escaping (APIResult<RCObject>) -> Void) {
        Alamofire.request(self.baseUrl+self.path, method: self.httpMethod, parameters: self.parameters, encoding: self.bodyEncoding, headers: self.headers).responseString { (response) in
            switch response.result {
            case .success(let value):
                switch response.response?.statusCode {
                    case 200:
                        do {
                            let xml = try XML.parse(value)
                            completion(.success(RCObject.init(accessor: xml)))
                        } catch {
                            // XML parse error handling
                            completion(.failure(error))
                    }
                    // API error handling
                    case 400:
                        completion(.failure(NetworkError.badRequest))
                    case 401:
                        completion(.failure(NetworkError.unauthorized))
                    case 403:
                        completion(.failure(NetworkError.forbidden))
                    case 404:
                        completion(.failure(NetworkError.notFound))
                    case 500:
                        completion(.failure(NetworkError.internalServerError))
                    case 503:
                        completion(.failure(NetworkError.serviceUnavailable))
                    // other error handling
                    default:
                        completion(.failure(NetworkError.networkRequestFail))
                }
            // error handling
            case .failure(let error):
                completion(.failure(error))
            }
        }
        
    }
}
