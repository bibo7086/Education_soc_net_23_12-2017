//
//  NetworkServices.swift
//  social_project
//
//  Created by Saeed Ali on 12/11/17.
//  Copyright © 2017 Saeed Ali. All rights reserved.
//

import Foundation





/*///Define the type of data we expect as a response
///
/// - JSON: it's a json
/// - Data: it's a plain Data

public enum DataType {
    case JSON
    case Data
}


//This is the request protocol

public protocol Request {
    // Realtive path of teh endpoint we want to call (i.e /users/login)
    var path        : String {  get }
    
    // This is the HTTP method we should use to perform the call
    var method : HTTPMethod {   get }
    
    //These are the parameters we need to send along with the request
    //They can be passed into the body or along with the URL
    var parameters: ReqestParams {  get }
    
    
    // what type of data do we expect as response
    var DataType : DataType { get }
    
}


// This enum defines teh type of HTTP method used to perfrom the request
public enum HTTPMethod: String {
    case post = "POST"
    case get = "GET"
}

//  Define parameters to pass along with the request and how they
//  encapsulated into the http request itself.
//  -   body: part of the body stream
//  -   url : as url parameters

public enum ReqestParams{
    case body(_ : [String: Any]?)
    case url(_ : [String: Any]?)
}


public enum userRequest: Request {
    case login(username: String, password: String)
    case avatar(username: String)
    
    public var path: String{
        switch self {
        case .login:
            return "student/login/"
        case .avatar(_):
            return "student/avatar"
        }
    }
    
    public var method: HTTPMethod{
        switch self {
        case .login(_, _):
            return .post
        case .avatar(_):
            return  .get
        }
    }
    
    public var parameters: ReqestParams{
        switch self {
        case .login(let username, let password):
            return .body(["student_number": username, "password": password])
        
        case .avatar(let username):
            return .url(["student_number": username])
        }
    }
    
    public var header : [String: Any]? {
        switch self {
        default:
            return   nil
        }
    }
    
    public var dataType: DataType {
        switch self {
        case .login(_,_):
            return .JSON
        case .avatar(_):
            return .Data
        }
    }
}
 */
/*
protocol ApiResouce {
    associatedtype Model
    var methodPath: String { get } //The path of the resource in teh URL
    
    /* This function takes a json serialization and converts it to teh appropriate Model value. This type is generic expressed by the associatedtype*/
    func makeModel(serialization: Serialization) -> Model
    
}

extension ApiResouce {
    var url: URL {
        let baseURL = "http://46.101.1.128/api/student/"
        
        let url = baseURL + methodPath
        return URL(string: url)!
        
    }
    
    
    func makeModel(data: Data) -> [Model]? {
        
        /*  Parse the data and use the data */
        
        guard let parsedResult = try? JSONSerialization.jsonObject(with: data, options: .allowFragments) as AnyObject else{
            print("unable to parse the data")
            return nil
        }
        
        print(parsedResult)
        
        /* Get records from Parsed data*/
        guard let records = parsedResult["records"] as? AnyObject  else {
            print("Could not sucessfully get records for this user")
            return nil
        }
        return nil //i have to fix here give it a proper return valu
    }
}


protocol NetworkRequest: class {
    associatedtype Model
    func load(withCompletion completion: @escaping(Model?) -> Void)
    func decode(_ data: Data) -> Model?
    
    
}


extension NetworkRequest {
    fileprivate func load(_ url: URL, withCompletion completion: @escaping (Model?) -> Void) {
        let configuration = URLSessionConfiguration.ephemeral
        let session = URLSession(configuration: configuration, delegate: nil, delegateQueue: OperationQueue.main)
        let task = session.dataTask(with: url, completionHandler: { [weak self] (data: Data?, response: URLResponse?, error: Error?) -> Void in
            guard let data = data else {
                completion(nil)
                return
            }
            completion(self?.decode(data))
        })
        task.resume()
    }
}

class ApiRequest <Resource: ApiResource> {
    let resource: Resource
    
    init(resource: Resource){
        self.resource = resource
    }
}
extension ApiRequest: NetworkRequest {
    func decode(_ data: Data) -> [Resource.Model]?{
        return resource.makeModel
    }
    
    func load(withCompletion completion: @escaping ([Resource.Model]?) -> Void) {
        load(resource.url, withCompletion: completion)
    }
}

*/

