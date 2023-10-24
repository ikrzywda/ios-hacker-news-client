//
//  HNClient.swift
//  GeneratedHNClient
//
//  Created by Igor Krzywda on 24/10/2023.
//

import OpenAPIURLSession


public struct HNClient {


    public init() {}


    public func getTopStories() async throws -> [Int32] {
        let client = Client(
            serverURL: try Servers.server1(),
            transport: URLSessionTransport()
        )
        let response = try await client.get_top_stories()
        switch response {
        case .ok(let okResponse):
            switch okResponse.body {
            case .json(let topStories):
                return topStories
            }
        case .undocumented(statusCode: let statusCode, _):
            return [-1, Int32(statusCode)]
        }
    }
}


