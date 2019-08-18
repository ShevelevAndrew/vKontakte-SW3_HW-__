//
//  NetworkService.swift
//  vKontakte
//
//  Created by Andrew on 15/08/2019.
//  Copyright © 2019 Andrew. All rights reserved.
//

import Foundation
import Alamofire

class NetworkService {
    
    private let host = "https://api.openweathermap.org"
    
    static let session: Session = {
        let config = URLSessionConfiguration.default
        config.timeoutIntervalForRequest = 60
        let session = Session(configuration: config)
        return session
    }()
    
    static func loadGroups() {
        let baseUrl = "https://api.vk.com"
        let path = "/method/groups.get"
        
        let params: Parameters = [
            "access_token": Sessions.shared.token,
            "extended": 1,
            "v": "5.92"
        ]
        
        NetworkService.session.request(baseUrl + path, method: .get, parameters: params).responseJSON { response in
            guard let json = response.value else { return }
            
            print(json)
        }
    }
    
    static func loadFriends() {
        let baseUrl = "https://api.vk.com"
        let path = "/method/friends.get"
        
        let params: Parameters = [
            "access_token": Sessions.shared.token,
            "user_id": Sessions.shared.userId,
            "fields": "nickname,domain,sex,bdate,city,country,photo_50,has_mobile,contacts",
            "v": "5.92"
        ]
        
        NetworkService.session.request(baseUrl + path, method: .get, parameters: params).responseJSON { response in
            guard let json = response.value else { return }
            
            print(json)
            
        }
    }
    
    static func loadFrend() {
        let baseUrl = "https://api.vk.com"
        let path = "/method/friends.get"
        let params: Parameters = [
            "access_token": Sessions.shared.token,
            "user_id": Sessions.shared.userId,
            "fields": "nickname,domain,sex,bdate,city,country,photo_50,has_mobile,contacts",
            "v": "5.92"
        ]
        NetworkService.session.request(baseUrl + path, method: .get, parameters: params).responseString { response in guard let string = response.value else { return }
            print(string)
        }
        
    }
    
}

