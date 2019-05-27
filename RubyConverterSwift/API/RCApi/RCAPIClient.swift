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

enum APIResult<T> {
    case success(T)
    case failure(Error)
}

// MARK: Custom Error
enum NetworkError: String, Error {
    case badRequest = "Bad request"
    case unauthorized = "Unauthorized"
    case forbidden = "Forbidden"
    case notFound = "Not Found"
    case internalServerError = "Internal Server Error"
    case serviceUnavailable = "Service unavailable"
    case networkRequestFail = "Network Request Fail"
    case unexpectedError = "Unexpected Error"
}

struct RCAPIClient {
    // MARK: default value
    let baseUrl: String = "https://jlp.yahooapis.jp"
    let path: String = "/FuriganaService/V1/furigana"
    let httpMethod: HTTPMethod = .get
    let headers: [String : String]? = nil
    let bodyEncoding: ParameterEncoding = URLEncoding.queryString
    
    let sentence: String
    let grade: Int
    
    // MARK: - Initメソッド
    init(sentence: String, grade: Int) {
        self.sentence = sentence
        self.grade = grade
    }
    
    // MARK: - ルビ振りXMLリクエスト
    func requestForRubyConvert(completion: @escaping (APIResult<RCObject>) -> Void) {
        let fullPathURL = self.baseUrl + self.path
        
        var parameters = ["appid" : AppID,
                    "sentence" : sentence]
        if 1...8 ~= grade {
            parameters["grade"] = String(grade)
        }
        
        Alamofire.request(fullPathURL, method: self.httpMethod, parameters: parameters, encoding: self.bodyEncoding, headers: self.headers).responseString { (response) in
            switch response.result {
            case .success(let value):
                // リクエスト成功
                switch response.response?.statusCode {
                    case 200:
                        do {
                            let xml = try XML.parse(value)
                            completion(.success(RCObject.init(accessor: xml)))
                        } catch {
                            // XML parse error handling
                            completion(.failure(NetworkError.unexpectedError))
                    }
                    // リクエスト成功ですがリスポンスコード２００以外の処理、API error handling
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
            // リクエスト失敗エラー処理
            case .failure( _):
                completion(.failure(NetworkError.networkRequestFail))
            }
        }
        
    }
}
