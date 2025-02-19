//
//  AppComponent.swift
//  ArtBridge
//
//  Created by 김창규 on 4/20/24.
//

import UIKit

final class AppComponent {
    var loginComponent: LoginComponent {
        return LoginComponent()
    }
    
    var mainTabComponent: MainTabComponent {
        return MainTabComponent()
    }
}
