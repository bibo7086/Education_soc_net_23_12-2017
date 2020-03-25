//
//  WebClient.swift
//  social_project
//
//  Created by Saeed Ali on 12/13/17.
//  Copyright © 2017 Saeed Ali. All rights reserved.
//

import Foundation

typealias  CompletionHandler = (_ success: Bool) -> Void

enum RequestMethod: String {
    case get = "GET"
    case post = "POST"
    case delete = "DELETE"
    case put = "PUT"
    case data = "DATA" //for something like an image
}


extension URL {
    init(baseUrl: String, path: String, params: JSON, method: RequestMethod) {
        
        var components = URLComponents(string: baseUrl)!
        components.path += path
        switch method {
        case .get, .delete:
            components.queryItems = params.map {
                URLQueryItem(name: $0.key, value: String(describing: $0.value))
            }
        default:
            break
        }
        
        self = components.url!
    }
}

extension URLRequest {
    init(baseUrl: String, path: String, method: RequestMethod, params: JSON) {
        let url = URL(baseUrl: baseUrl, path: path, params: params, method: method)
        self.init(url: url)
        httpMethod = method.rawValue
        setValue("application/json", forHTTPHeaderField: "Accept")
        setValue("application/json", forHTTPHeaderField: "Content-Type")

        //  setValue("3298406bb04daef3d74033e3053d1a12", forHTTPHeaderField: "ACCESSTOKEN")
        switch method {
        case .post, .put:
            httpBody = try! JSONSerialization.data(withJSONObject: params, options: [])
        default:
            break
        }
    }
}

final class WebClient{
    private var baseUrl: String
    
    init(baseUrl: String) {
        self.baseUrl = baseUrl
    }
    
    
    func load(path: String, method: RequestMethod, params: JSON, completion: @escaping (JSON?, ServiceError?) -> ()) -> URLSessionDataTask? {
        //  checking internet connection availability
        if !Reachability.isConnectedToNetwork() {
            completion(nil, ServiceError.noInternetConnection)
            return nil
        }
        
        // Creating the URLRequest object
        let request = URLRequest(baseUrl: baseUrl, path: path, method: method, params: params)
        
        /* Make the request */
        let task = URLSession.shared.dataTask(with: request as URLRequest) { (data, response, error) in
        
            /* GUARD: Was there an error? */
            guard (error == nil) else {
                completion(nil, ServiceError.custom("There was an error with your request"))
                return
            }
            
            /* GUARD: Was there any data returned? */
            guard let data = data else {
                completion(nil, ServiceError.other)
                return
            }
            
            /*  Parse the data and use the data */
            var parsedResult: AnyObject! = nil
            do {
                parsedResult = try JSONSerialization.jsonObject(with: data, options: .allowFragments) as AnyObject
            } catch {
                print("This one \(data)")
                print("there was a problem parsing your result")
                completion(nil, ServiceError.other)
                return
            }
            
            /* Get the response code */
            guard let RC = parsedResult["RC"] as? Int, RC >= 200 && RC <= 299 else {
                let error = (parsedResult as? JSON).flatMap(ServiceError.init) ?? ServiceError.other
                completion(nil, error)
                return
            }
            completion(parsedResult as? JSON, nil)
        }
        task.resume()
        return task
    }
    
    func taskForGetImage(from url: String, completion: @escaping (_ imageData: Data?, ServiceError?) -> ()) -> URLSessionDataTask? {
        //  checking internet connection availability
        if !Reachability.isConnectedToNetwork() {
            completion(nil, ServiceError.noInternetConnection)
            return nil
        }
        // Creating the URLRequest object
        let request = URLRequest(url: URL(string: self.baseUrl)!)
        
        /* Make the request */
        let task = URLSession.shared.dataTask(with: request as URLRequest) { (data, response, error) in
            
            /* GUARD: Was there an error? */
            guard (error == nil) else {
                completion(nil, ServiceError.custom("There was an error with your request"))
                return
            }
            
            /* GUARD: Was there any data returned? */
            guard let data = data else {
                completion(nil, ServiceError.other)
                return
            }
            completion(data, nil)
        }
        task.resume()
        return task
    }
}

