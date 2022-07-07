////
// Created by Syd Polk on 7/7/22.
//
// Copyright © 2022 Syd Polk
// All Rights Reserved.
//


import SwiftUI

struct WelcomeScreen: View {
    @Binding var welcomeScreenShowing: Bool

    let system = (UIApplication.shared.delegate as! AppDelegate).system
    
    var body: some View {
        VStack {
            Spacer()
            Text("Welcome to the Bone Jarring \(system) Character Generator.").multilineTextAlignment(.center)
            Spacer()
            Button(action: {
                withAnimation() {
                    let defaults = UserDefaults.standard
                    defaults.set(true, forKey: "WelcomeScreenShown")
                    welcomeScreenShowing = false
                }
            }) {
                Text("Let's go!")
            }
            Spacer()
        }
    }
}

struct WelcomeScreen_Previews: PreviewProvider {
    @State static var welcomeScreenShowing = true
    
    static var previews: some View {
        WelcomeScreen(welcomeScreenShowing: $welcomeScreenShowing)
    }
}
