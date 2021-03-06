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
  private var collection: Set<HTTPHost> = Set()
  
  fileprivate init() {}
  
  func hostFor<Resource: HostedResource>(_ resource: Resource) -> HTTPHost?
  {
    return collection.filter { type(of: $0) == resource.HostType }.first
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

private(set) var hostRegistry = HostRegistry()

public func configure<H: HTTPHost>(host: H)
{
  hostRegistry.register(host)
}

public protocol HostedResource
{
  var HostType: AnyClass { get }
}

