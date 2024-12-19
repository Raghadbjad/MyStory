//
//  ReviewPage.swift
//  MyStory
//
//  Created by Raghad on 18/06/1446 AH.
//

import SwiftUI
import AVFoundation
import _AVKit_SwiftUI

struct ReviewPage: View {
    var videoURL: URL?

    var body: some View {
        
        
        ZStack{
            
            Image("Background")
                .resizable()
                .scaledToFill()
                .ignoresSafeArea()
            
            VStack {
                if let url = videoURL {
                    VideoPlayer(player: AVPlayer(url: url))
                        .frame(height: 300)
                    
                }
               
                Text("حكايتك الرائعة أصبحت جاهزة للنشر..")
                    .font(.custom("SF Arabic", size: 55))
                    .shadow(radius: 15)
                    .multilineTextAlignment(.center)
                    .fontWeight(.bold)
                
                HStack (spacing: 30){
                    Button(action: {
                        // Action for إعادة
                    }) {
                        Image(systemName: "repeat.circle")
                            .font(.largeTitle)
                            
                    }
                    
                    Button(action: {
                        // Action for رفع
                    }) {
                        Image(systemName: "square.and.arrow.up")
                            .font(.largeTitle)
                    }
                    
                    Button(action: {
                        // Action for إضافة
                    }) {
                        Image(systemName: "plus.circle")
                            .font(.largeTitle)
                    }
                    
                }
                .padding(.top )
            }
        }
    }
}

#Preview {
    
    ReviewPage()
}

