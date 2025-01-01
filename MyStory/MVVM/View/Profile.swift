//
//  Profile.swift
//  MyStory
//
//  Created by Raghad on 01/07/1446 AH.
//

import SwiftUI
//
//struct Profile: View {
//    
//    var body: some View {
//     
//            
//            ZStack {
//                Image("Background")
//                    .resizable()
//                    .scaledToFill()
//                    .ignoresSafeArea()
//                
//                VStack {
//                    Image("ProfileBoy")
//                        .padding()
//                        .frame(width: 400, height: 400)
//                        .imageScale(.large)
//                        .foregroundStyle(.tint)
//                        .padding(.bottom)
//                    Spacer()
//                }
//            }
//       
//        
//        }
//    }
//
//
//
//#Preview {
//    Profile()
//}


import SwiftUI
import AVKit

struct Profile: View {
    @State private var videoURL: URL? // URL الخاص بالفيديو المسجل
    @State private var showVideoPlayer = false // للتحكم في عرض مشغل الفيديو

    var body: some View {
        ZStack {
            // الخلفية
            Image("Background")
                .resizable()
                .scaledToFill()
                .ignoresSafeArea()

            VStack {
                Spacer()

                // زر تشغيل الفيديو
                if let videoURL = videoURL {
                    Button(action: {
                        showVideoPlayer = true
                    }) {
                        VStack {
                            Image(systemName: "play.rectangle.fill")
                                .font(.system(size: 100))
                                .foregroundColor(.blue)
                                .shadow(radius: 10)
                            Text("عرض الفيديو")
                                .font(.title)
                                .foregroundColor(.white)
                                .padding(.top, 10)
                        }
                    }
                    .padding()
                    .background(Color.white.opacity(0.7))
                    .clipShape(Circle())
                    .shadow(radius: 10)
                } else {
                    Text("لا يوجد فيديو مسجل")
                        .font(.title)
                        .foregroundColor(.white)
                        .padding()
                }

                Spacer()
            }
        }
        .fullScreenCover(isPresented: $showVideoPlayer) {
            if let videoURL = videoURL {
                VideoPlayer(player: AVPlayer(url: videoURL))
                    .ignoresSafeArea()
            }
        }
        .onAppear {
            // تحميل الفيديو إذا كان متوفراً
            loadVideo()
        }
    }

    // دالة لتحميل الفيديو المسجل
    func loadVideo() {
        let fileName = "screenRecording.mp4" // اسم الملف المسجل
        let filePath = FileManager.default.temporaryDirectory.appendingPathComponent(fileName)

        if FileManager.default.fileExists(atPath: filePath.path) {
            videoURL = filePath
        } else {
            print("No recorded video found.")
        }
    }
}

#Preview {
    Profile()
}
