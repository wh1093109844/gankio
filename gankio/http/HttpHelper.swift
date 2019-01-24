//
//  HttpHelper.swift
//  gankio
//
//  Created by za-wanghe on 2019/1/12.
//  Copyright © 2019 za-wanghe. All rights reserved.
//

import Foundation
import os.log
class HttpHelper {
    enum Method: String {
        case GET = "GET"
        case POST = "POST"
    }

    static func reques<T: Encodable, R: Decodable>(url: String, method: Method, params: [String:String]?, body: T, callback: @escaping (Response<R>?, URLResponse?, Error?) -> Void) -> URLSessionDataTask? {
        var urlComponent = URLComponents(string: url)
        if (params != nil) {
            var queryItems: [URLQueryItem] = []
            for (key, value) in params! {
                queryItems.append(URLQueryItem(name: key, value: value))
            }
            urlComponent?.queryItems = queryItems
        }
        guard let uri = urlComponent?.url else {
            callback(nil, nil, nil)
            return nil
        }
        var request = URLRequest(url: uri)
        request.httpMethod = method.rawValue
        do {
            if !(body is Empty) {
                let encoder = JSONEncoder()
                let bodyData = try encoder.encode(body)
                request.httpBody = bodyData
            }
        } catch {
            os_log("encode body error")
        }
        let task = URLSession.shared.dataTask(with: request) {(data, urlResponse, error) -> Void in
            if (error != nil) {
                callback(nil, urlResponse, error)
                return
            }
            let decoder = JSONDecoder()
            decoder.dateDecodingStrategy = .formatted(DateFormatter.iso8601)
            do {
                let response: Response<R> = try decoder.decode(Response<R>.self, from: data!)
                callback(response, urlResponse, error)
            } catch {
                callback(nil, urlResponse, error)
            }
        }
        task.resume()
        return task
    }
    
    static func request<T: Decodable>(url: String, method: Method, params: [String: String]?, callback: @escaping (Response<T>?, URLResponse?, Error?) -> Void) -> URLSessionDataTask? {
        return reques(url: url, method: method, params: params, body: Empty(), callback: callback)
    }
    
    static func get<T: Decodable>(url: String, params:[String: String]?, callback: @escaping (Response<T>?, URLResponse?, Error?) -> Void) -> URLSessionDataTask? {
        return request(url: url, method: Method.GET, params: params, callback: callback)
    }
    
    static func get<T: Decodable>(url: String, callback: @escaping (Response<T>?, URLResponse?, Error?) -> Void) -> URLSessionDataTask? {
        return get(url: url, params: nil, callback: callback)
    }
    
    static func post<T: Encodable, R: Decodable>(url: String, params: [String: String]?, body: T, callback: @escaping (Response<R>?, URLResponse?, Error?) -> Void) -> URLSessionDataTask? {
        return request(url: url, method: Method.POST, params: params, callback: callback)
    }
    static func post<T: Encodable, R: Decodable>(url: String, body: T, callback: @escaping (Response<R>?, URLResponse?, Error?) -> Void) -> URLSessionDataTask? {
        return post(url: url, params: nil, body: body, callback: callback)
    }
    
    static func post<T: Decodable>(url: String, params: [String: String]?, callback: @escaping (Response<T>?, URLResponse?, Error?) -> Void) -> URLSessionDataTask? {
        return post(url: url, params: params, body: Empty(), callback: callback)
    }
    
    static func post<T: Decodable>(url: String, callback: @escaping (Response<T>?, URLResponse?, Error?) -> Void) -> URLSessionDataTask? {
        return post(url: url, params: nil, callback: callback)
    }
    
    private struct Empty : Codable {
    
    }
    
    private init() {}
}

extension DateFormatter {
    static let iso8601: DateFormatter = {
        return createFormatter(format: "yyyy-MM-dd'T'HH:mm:ss.SSSX")
    }()
    
    static let `default`: DateFormatter = {
        return createFormatter(format: "yyyy-MM-dd HH:mm:ss")
    }()
    
    private static func createFormatter(format: String) -> DateFormatter {
        let formatter = DateFormatter()
        formatter.dateFormat = format
        return formatter
    }
}
