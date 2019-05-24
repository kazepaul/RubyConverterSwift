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
        return ["appid" : AppID,
             "sentence" : self.sentence,
                "grade" : self.grade]
    }
    
    var headers: [String : String]? = nil
    
    var bodyEncoding: ParameterEncoding {
        return URLEncoding.default
    }
    
    var sentence: String
    var grade: String
    
    
    init(sentence: String, grade: String) {
        self.sentence = sentence
        self.grade = grade
    }
    
    func requestForRubyConvert(completion: @escaping (_ furiganaText: String) -> Void) {
        Alamofire.request(self.baseUrl+self.path, method: self.httpMethod, parameters: self.parameters, encoding: self.bodyEncoding, headers: self.headers)
            .responseString(completionHandler: { (respond: DataResponse<String>) in
                let xml = try! XML.parse(respond.value ?? "")
                var furiganaText: String = ""
                for hit in xml["ResultSet", "Result", "WordList", "Word"] {
                    if let Furigana = hit.Furigana.text {
                        furiganaText += Furigana
                    }
                    else if let Surface = hit.Surface.text {
                        furiganaText += Surface
                    }
                }
                completion(furiganaText)
        })
    }
}
