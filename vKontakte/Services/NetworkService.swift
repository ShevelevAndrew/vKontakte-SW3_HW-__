//
//  NetworkService.swift
//  vKontakte
//
//  Created by Andrew on 15/08/2019.
//  Copyright © 2019 Andrew. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

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
    
    static func loadGroup(completion: @escaping (Result<[GroupModels], Error>) -> Void) {
        let baseUrl = "https://api.vk.com"
        let path = "/method/groups.get"
        let params: Parameters = [
            "access_token": Sessions.shared.token,
            "extended": 1,
            "v": "5.92"
        ]
        NetworkService.session.request(baseUrl + path, method: .get, parameters: params).responseJSON { response in
            switch response.result {
            case .success(let value):
                let json = JSON(value)
                let groupsJson = json["response"]["items"].arrayValue
                let groups = groupsJson.map { GroupModels($0) }
                completion(.success(groups))
                
            case .failure(let error):
                completion(.failure(error))
            }
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
            "fields": "nickname,domain,sex,bdate,city,country,photo_50,photo_100,has_mobile,contacts",
            "v": "5.92"
        ]
        NetworkService.session.request(baseUrl + path, method: .get, parameters: params).responseData { response in
            switch response.result {
            case .success(let data):
                let decoder = JSONDecoder()
                do {
                   let users = try decoder.decode(FriendModel.self, from: data)
                    users.response.items.forEach { print("\($0.firstName): \($0.lastName)")}
              
                } catch {
                    print(error)
                }
            case .failure(let error):
                print(error)
            }
        }
        
    }
    
    func loadFrienddd(completion: @escaping ([FriendModels]) -> Void) {
        let baseUrl = "https://api.vk.com"
        let path = "/method/friends.get"
        let params: Parameters = [
            "access_token": Sessions.shared.token,
            "user_id": Sessions.shared.userId,
            "fields": "nickname,domain,sex,bdate,city,country,photo_50,photo_100,has_mobile,contacts",
            "v": "5.92"
        ]
        NetworkService.session.request(baseUrl + path, method: .get, parameters: params).responseJSON { response in
            switch response.result {
            case .success(let value):
                let json = JSON(value)
                print(json)
                let friendJSONs = json["response"]["items"].arrayValue
                let friends = friendJSONs.map { FriendModels($0) }
                friends.forEach { print("\($0.name) \($0.image)") }
                completion(friends)
            case .failure(let error):
                print(error)
                completion([])
            }
        }
    }
    
    static func fetchPhotos(for userId: Int, completion: @escaping (Result<[Photo], Error>) -> Void ) {
        var urlComponents = URLComponents()
        urlComponents.scheme = "https"
        urlComponents.host = "api.vk.com"
        urlComponents.path = "/method/photos.getAll"
        urlComponents.queryItems = [
            URLQueryItem(name: "access_token", value: Sessions.shared.token),
            URLQueryItem(name: "owner_id", value: String(userId)),
            URLQueryItem(name: "extended", value: "1"),
            URLQueryItem(name: "v", value: "5.92")
        ]
        
        guard let url = urlComponents.url else { fatalError("Request url was badly formated.")}
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.allowsCellularAccess = false
        
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            if let error = error {
                completion(.failure(error))
                return
            }
            
            guard let data = data,
                let json = try? JSON(data: data) else { return }
            
            let photosJSON = json["response"]["items"].arrayValue
            let photos = photosJSON.map { Photo(json: $0) }
            
            DispatchQueue.main.async {
                completion(.success(photos))
            }
        }
        task.resume()
    }
    
}

