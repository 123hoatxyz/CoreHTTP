//
//  HTTPResource.swift
//  GaugesAPI
//
//  Created by Saul Mora on 6/19/16.
//  Copyright © 2016 Magical Panda Software. All rights reserved.
//

import Argo
import Runes
import Result
import Foundation

public typealias ResourceParseResult<ResourceType> = Result<ResourceType, HTTPResponseError>
//public typealias ResourceParseFunction<ResourceType> = (Data) -> ResourceParseResult<ResourceType>

public protocol HTTPResourceProtocol
{
  associatedtype ResourceType
  associatedtype ErrorType: HTTPResourceError
  associatedtype Method: HTTPMethod
  
  var path: String { get }
  var method: Method { get }
  var queryParameters: [String: String] { get }
  var parse: (Data) -> ResourceParseResult<ResourceType> { get }
}

open class HTTPResource<RequestedType, Method: HTTPMethod>: HTTPResourceProtocol
{
  public typealias ErrorType = HTTPResponseError
  
  public let path: String
  public let method: Method
  public let queryParameters: [String : String]
  public let parse: (Data) -> ResourceParseResult<RequestedType>
  
  public init(path: String, method: Method, queryParameters: [String: String] = [:], parse: @escaping (Data) -> ResourceParseResult<RequestedType>)
  {
    self.path = path
    self.method = method
    self.queryParameters = queryParameters
    self.parse = parse
  }
}

public class QueriableHTTPResource<RequestedType>: HTTPResource<RequestedType, QueriableHTTPMethod>
{
  public override init(path: String, method: QueriableHTTPMethod = .GET, queryParameters: [String: String] = [:], parse: @escaping (Data) -> ResourceParseResult<RequestedType>)
  {
    super.init(path: path, method: method, queryParameters: queryParameters, parse: parse)
  }
}

public class UpdatableHTTPResource<RequestedType>: HTTPResource<RequestedType, UpdatableHTTPMethod>
{
  public override init(path: String, method: UpdatableHTTPMethod = .POST, queryParameters: [String: String] = [:], parse: @escaping (Data) -> ResourceParseResult<RequestedType>)
  {
    super.init(path: path, method: method, queryParameters: queryParameters, parse: parse)
  }
}
