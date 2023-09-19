//
//  GggApp.swift
//  Ggg
//
//  Created by Batman 👀 on 18.09.2023.
//

import SwiftUI

@main
struct MainApp: App {
    @StateObject var coordinator = AppCoordinator()
    
    var body: some Scene {
        WindowGroup {
            NavigationView {
                HotelView(viewModel: HotelViewModel())
                    .environmentObject(coordinator)
            }
        }
    }
}

