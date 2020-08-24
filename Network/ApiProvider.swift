//
//  ApiProvider.swift
//  Kasumi
//
//  Created by docotel on 23/08/20.
//  Copyright © 2020 Affandy Murad. All rights reserved.
//

import Foundation
import Moya

enum ApiProvider {
    case allmovie(api: String, region: String, language: String, page: String)
    case detailmovie(api: String, id: String, append_to_response: String)
}

extension ApiProvider: TargetType{
    var sampleData: Data {
        return Data()
    }
    
    var headers: [String : String]? {
        return [:]
    }
    
    var baseURL: URL {
        guard let url = URL(string: NetworkManager.baseUrl) else {
            fatalError("Server Bermasalah")
        }
        return url
    }
    
    var path: String {
        switch self {
        case .allmovie:
            return "/movie/now_playing"
        case .detailmovie(_, let id, _):
            return "movie/\(id)"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .allmovie,
             .detailmovie:
            return .get
        }
    }
    
    var task: Task {
        switch self {
        case .allmovie(let api, let region, let language, let page):
            return .requestParameters(parameters: ["api_key": api,
                                                   "region": region,
                                                   "language": language,
                                                   "page":page], encoding: URLEncoding.queryString)
        case .detailmovie(let api, _, let append_to_response):
            return .requestParameters(parameters: ["api_key": api,
                                                   "append_to_response":append_to_response], encoding: URLEncoding.queryString)
        }
    }
    
}

