//
//  HTTPUtility.swift
//  GaugesAPI
//
//  Created by Saul Mora on 6/19/16.
//  Copyright © 2016 Magical Panda Software. All rights reserved.
//

import Foundation

struct HostRegistry
{
  var collection: Set<HTTPHost> = Set()
  
  private init() {}
  
  func hostFor<Resource: HostedResource>(_ resource: Resource) -> HTTPHost?
  {
    return collection.filter { $0.dynamicType == resource.HostType }.first
  }
  
  mutating func register<Host: HTTPHost>(_ host: Host)
  {
    collection.insert(host)
  }
  
  mutating func unregister<Host: HTTPHost>(_ host: Host)
  {
    collection.remove(host)
  }
}

var hostRegistry = HostRegistry()

public func configure<H: HTTPHost>(host: H)
{
  hostRegistry.register(host)
}


/// Utilities

func convertToQueryString(dictionary: [String: String]) -> String?
{
  guard !dictionary.isEmpty else {  return nil }
  
  return dictionary
    .map { "\($0)=\($1)" }
   .joined(separator: "&")
}

func log(message: String)
{
  print(message)
}

extension Int
{
  var seconds: TimeInterval
  {
    return TimeInterval(self)
  }
}
