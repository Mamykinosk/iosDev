//
//  NavigationApp.swift
//  Navigation
//
//  Created by OstapMamykin on 30.12.2025.
//

import SwiftUI

@main
struct NavigationApp: App {
    var body: some Scene {
        WindowGroup {
            RootView()
        }
    }
}


struct RootView: View {
    @Bindable var viewModel: ViewModel = .init()
    
    var body: some View {
        ListView(viewModel: viewModel)
    }
}


#Preview {
    RootView()
}
