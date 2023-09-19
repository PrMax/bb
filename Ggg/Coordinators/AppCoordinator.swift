
import Foundation
import SwiftUI

class AppCoordinator: ObservableObject {
    @Published var currentScreen: Screens = .hotel

    enum Screens {
         case hotel, number, booking, paid
     }

     func navigateTo(_ screen: Screens) {
         currentScreen = screen
     }
    
    func canGoBack() -> Bool {
            return currentScreen != .hotel
        }
    }



