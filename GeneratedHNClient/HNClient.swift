//
//  HNClient.swift
//  GeneratedHNClient
//
//  Created by Igor Krzywda on 24/10/2023.
//

import OpenAPIURLSession

public typealias HNItem = Components.Schemas.Item
public typealias HNGetItemSchema = Operations.get_item.Input
public typealias HNGetItemPath = Operations.get_item.Input.Path

public struct HNClient {

    private let client: Client?

    public init() throws {
        do {
            self.client = try Client(
                serverURL: Servers.server1(),
                transport: URLSessionTransport()
            )
        } catch {
            self.client = nil
        }
    }

    public func getTopStories() async throws -> [Int32] {
        guard let client else { throw URLError(.cannotConnectToHost) }
        let response = try await client.get_top_stories()
        switch response {
        case .ok(let okResponse):
            switch okResponse.body {
            case .json(let topStories):
                return topStories
            }
        case .undocumented:
            throw URLError(.badServerResponse)
        }
    }
    
    public func getItem(itemId: Int) async throws -> HNItem {
        guard let client else { throw URLError(.cannotConnectToHost) }
        
        let response = try await 
            client.get_item(HNGetItemSchema(path: HNGetItemPath(id: String(itemId))))
        switch response {
        case .ok(let okResponse):
            switch okResponse.body {
            case .json(let item):
                return item
            }
        case .undocumented:
            throw URLError(.badServerResponse)
        }
    }
}


