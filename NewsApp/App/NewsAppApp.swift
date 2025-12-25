//
//  NewsAppApp.swift
//  NewsApp
//
//  Created by Avinash on 23/12/25.
//

import SwiftUI

@main
struct NewsAppApp: App {
    private let di = AppDIContainer.shared
    var body: some Scene {
        WindowGroup {
            MainTabView(di: di)
        }
    }
}
