//
//  Splash.swift
//  MyStory
//
//  Created by Raghad on 17/06/1446 AH.
//

import SwiftUI

struct Splash: View {
    @State private var showNextPage = false
    var body: some View {
        if showNextPage {
            Main()
        } else {
            
            ZStack {
                Image("Background")
                    .resizable()
                    .scaledToFill()
                    .ignoresSafeArea()
                
                VStack {
                    Image("Logo")
                        .padding()
                        .frame(width: 250, height: 250)
                        .imageScale(.large)
                        .foregroundStyle(.tint)
                        .padding(.bottom)
                    
                    Text("استمع، تخيل، وعبّر... مرحبًا بك في عالم الحكايات!")
                        .font(.custom("SF Arabic", size: 40))
                        .shadow(radius: 15)
                        .foregroundColor(.black)
                        .multilineTextAlignment(.center)
                        .fontWeight(.bold)
                        .padding()
                }
            }
            .onAppear {
                // الانتقال بعد 3 ثوانٍ
                DispatchQueue.main.asyncAfter(deadline: .now() + 3.0) {
                    self.showNextPage = true
                }
            }
        }
    }
}


#Preview {
    Splash()
}

