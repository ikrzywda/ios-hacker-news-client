//
//  ContentView.swift
//  HackerNewsSwift
//
//  Created by Igor Krzywda on 24/10/2023.
//

import SwiftUI
import GeneratedHNClient

struct ContentView: View {
    @State private var apiResult: [Int32] = []
    var body: some View {
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundStyle(.tint)
            Text("Hello, HN openapi client!")
            ForEach(apiResult, id: \.self) { res in
                Text("\(res)")
            }
        }
        .padding()
        .onAppear {
            Task {
                apiResult = try await GeneratedHNClient.HNClient().getTopStories()
                print(apiResult)
            }
        }
    }
}

#Preview {
    ContentView()
}
