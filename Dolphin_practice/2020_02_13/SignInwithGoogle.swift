//
//  SignInwithGoogle.swift
//  Dolphin_practice
//
//  Created by 박찬영 on 2020/02/12.
//  Copyright © 2020 박찬영. All rights reserved.
//

import SwiftUI
import GoogleSignIn

struct SignInwithGoogle: View {
    var body: some View {
        google().frame(width:120,height: 50)

    }
}

struct SignInwithGoogle_Previews: PreviewProvider {
    static var previews: some View {
        SignInwithGoogle()
    }
}

struct google : UIViewRepresentable {
    func makeUIView(context: UIViewRepresentableContext<google>) -> GIDSignInButton {
        let button = GIDSignInButton()
        button.colorScheme = .dark
        GIDSignIn.sharedInstance()?.presentingViewController = UIApplication.shared.windows.last?.rootViewController
        return button
    }
    
    func updateUIView(_ uiView: GIDSignInButton, context: UIViewRepresentableContext<google>) {
        
    }
}
