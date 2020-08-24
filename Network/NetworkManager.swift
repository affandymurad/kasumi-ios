//
//  NetworkManager.swift
//  Kasumi
//
//  Created by docotel on 23/08/20.
//  Copyright © 2020 Affandy Murad. All rights reserved.
//

import Foundation
import Moya
import Alamofire


class NetworkManager {
    static let baseUrl = "https://api.themoviedb.org/3"
    static let token = "f002c90cf2d54e6b83801cbe9408e82b"
    static let baseImage = "http://image.tmdb.org/t/p/w500"
    static let sharedInstance = MoyaProvider<ApiProvider>(session: DefaultAlamofireManager.sharedManager, plugins: [NetworkLoggerPlugin()])
}

class DefaultAlamofireManager: Alamofire.Session {
    static let sharedManager: DefaultAlamofireManager = {
        let configuration = URLSessionConfiguration.default
        configuration.timeoutIntervalForRequest = 10 // as seconds, you can set your request timeout
        configuration.timeoutIntervalForResource = 10 // as seconds, you can set your resource timeout
        configuration.requestCachePolicy = .useProtocolCachePolicy
        return DefaultAlamofireManager(configuration: configuration)
    }()
}
