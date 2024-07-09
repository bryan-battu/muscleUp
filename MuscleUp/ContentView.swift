//
//  ContentView.swift
//  MuscleUp
//
//  Created by Bryan Battu on 14/01/2024.
//

import SwiftUI
import AlertToast

struct ContentView: View {
    /// View Properties
    @State private var showSignUp: Bool = false
    @ObservedObject var authViewModel = AuthViewModel()
    var userViewModel = UserViewModel()
    
    @State private var showToast = false
    @State private var errorMessage = ""
    
    var body: some View {
        ZStack {
            if LoginManager.shared.getSavedAccessToken() != nil || authViewModel.isLoggedIn {
                Root()
                    .environmentObject(authViewModel)
            } else {
                NavigationStack {
                    Login(showSignUp: $showSignUp, authViewModel: authViewModel)
                        .navigationDestination(isPresented: $showSignUp) {
                            SignUp(showSignUp: $showSignUp, authViewModel: authViewModel)
                        }
                }
            }
        }
        .onReceive(NotificationCenter.default.publisher(for: Notification.Name("UnauthorizedAccess"))) { _ in
            LoginManager.shared.actionsLogOut()
        }
        .onReceive(NotificationCenter.default.publisher(for: Notification.Name("ShowToastNotification"))) { notification in
            guard let message = notification.object as? String else { return }
            self.showToast = true
            self.errorMessage = message
        }
        .onReceive(NotificationCenter.default.publisher(for: UIApplication.didBecomeActiveNotification)) { _ in
            if LoginManager.shared.user != nil {
                userViewModel.getMe { user in
                    
                }
            }
        }
        .toast(isPresenting: $showToast) {
            AlertToast(displayMode: .hud, type: .regular, title: errorMessage)
        }
    }
}

#Preview {
    ContentView()
}
