//
//  ContentView.swift
//  HackerNewsSwift
//
//  Created by Igor Krzywda on 24/10/2023.
//

import SwiftUI
import GeneratedHNClient

struct Post: View {
    let itemId: Int
    @State private var isLoading: Bool = false
    @State private var item: HNItem?
    
    var body: some View {
        VStack {
            HStack {
                if isLoading {
                    Circle().frame(width: 12, height: 12).foregroundColor(.green)
                }
                Text(item?.title ?? "")
                Spacer()
            }
            HStack {
                Text(item?.url ?? "")
                Spacer()
            }
        }.onAppear {
            Task {
                isLoading = true
                item = try await GeneratedHNClient.HNClient().getItem(itemId: itemId)
                isLoading = false
            }
        }
    }
}

struct ContentView: View {
    @State private var apiResult: [Int32] = []
    var body: some View {
        ScrollView {
            VStack {
                Image(systemName: "globe")
                    .imageScale(.large)
                    .foregroundStyle(.tint)
                Text("Hello, HN openapi client!")
                if !apiResult.isEmpty {
                    ForEach(apiResult, id: \.self) { res in
                        Post(itemId: Int(res))
                    }
                }
            }
        }
        .padding()
        .onAppear {
            Task {
                apiResult = try await GeneratedHNClient.HNClient().getTopStories()
            }
        }
    }
}

#Preview {
    ContentView()
}
