//
//  DDAPIRequest.swift
//  JatAppTest
//
//  Created by Duba on 03.09.2018.
//  Copyright © 2018 Duba. All rights reserved.
//


import Alamofire
import SwiftyJSON
import ObjectMapper
//password DmytroDubin, name Dmytro Dubin , email dubindmytro.ua@gmail.com
class DDAPIRequest {
    static let instance = DDAPIRequest()
    
    let localAccessToken = "d-0Dknws0RF85mTjMixROb0Bct1mzfWt"
    func showSignInError(result : JSON) -> String  {
        var errorDescription = ""
        let error = result["error"].stringValue
        for err in error {
            errorDescription = "\(errorDescription) \(err) "
        }
        return errorDescription
    }
    
    
    
    func singUp(withLogin login : String, email : String, andPassword password : String, completion : @escaping (_ user: DDUser?, _ error: String?) -> Void) {
        let params = ["name": "\(login)", "email": "\(email)", "password": "\(password)"]
        request("https://apiecho.cf/api/signup/", method: .post, parameters: params).responseJSON {[unowned self] (res) in
            
            if res.result.isSuccess {
                var result = JSON(res.result.value!)
                let accessToken = result["data"]["access_token"].stringValue
                if accessToken != "" {
                    let user = DDUser(JSONString: result["data"].description)
                    completion(user,nil)
                    
                } else {
                    let message = self.getErrorsMessage(json: result)
                    completion(nil,message)
                }
     
            }
        }
    }
    func singIn(withEmail email : String, andPassword password : String, completion : @escaping (_ user: DDUser?, _ error: String?) -> Void)  {
        let params = ["email": email, "password": password]
        request("https://apiecho.cf/api/login/", method: .post, parameters: params).responseJSON {[unowned self] (res) in
            
            if res.result.isSuccess {
                var result = JSON(res.result.value!)
                let accessToken = result["data"]["access_token"].stringValue
                if accessToken != "" {
                    let user = DDUser(JSONString: result["data"].description)
                    completion(user,nil)
              
                } else {
                    let message = self.getErrorsMessage(json: result)
                    
                    completion(nil,message)
                }
            }
        }
    }
  
    
    func getText(withAccessToken accessToken : String, completion : @escaping (_ loadText: String?, _ error: String?) -> Void){
        let headers = [
            "Authorization": "Bearer \(accessToken)",
        ]
        
        request("https://apiecho.cf/api/get/text/", method: .get, parameters: nil, encoding: JSONEncoding.default, headers: headers).responseJSON { (res) in
            if res.result.isSuccess {
                var result = JSON(res.result.value!)
                let text = result["data"].stringValue
                if text != "" {
                    completion(text,nil)
                } else {
                    completion(nil,"error load text")
                }
                
            }
        }
    }
    private func getErrorsMessage(json : JSON) -> String{
        var message = ""
        let errors = json["errors"]
        for (_, subJson) in errors{
            if subJson["message"].stringValue != "" {
                if message == "" {
                     message = subJson["message"].stringValue
                } else {
                    message = "\(message)\n" + subJson["message"].stringValue
                }
            }
        }
        return message
    }
        
}

