//
//  Explore.swift
//  MyStory
//
//  Created by Raghad on 18/06/1446 AH.
//

import SwiftUI
import AVKit

struct MainContentView: View {
    var body: some View {
        ZStack {
            // الخلفية
            Image("Background")
                .resizable()
                .scaledToFill()
                .edgesIgnoringSafeArea(.all)

            VStack(spacing: 40) { // زيادة التباعد العمودي قليلاً
                // الشعار والعنوان
                VStack(spacing: 20) {
                    Image("Logo")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 200, height: 200) // تكبير الشعار
                        .padding(.top, 40)
                    Text("اكتشف القصص")
                        .font(.custom("FS Arabic", size: 60)) // تطبيق الخط المخصص
                        .foregroundColor(.black) // اللون الأسود للنص
                        .padding(.top, 5)
                }

                Spacer()

                // مربعات القصص
                HStack(spacing: 30) { // ضبط المسافات بين الصور
                    // القصة الأولى
                    StoryCardView(
                        imageName: "Story1",
                        videoName: "BoyVideo",
                        title: "سامى يتعلم الشجاعة"
                    )

                    // القصة الثانية
                    StoryCardView(
                        imageName: "Story2",
                        videoName: "GirlVideo",
                        title: "سوسن تعبر عن غضبها بحب"
                    )
                }
                .padding(.horizontal, 20) // مسافة من أطراف الشاشة
                .frame(maxWidth: .infinity, alignment: .center) // توسيط الصور أفقيًا

                Spacer()
            }
            .padding()
        }
    }
}

struct StoryCardView: View {
    let imageName: String
    let videoName: String
    let title: String // العنوان الذي يظهر تحت الصورة

    var body: some View {
        VStack(spacing: 15) { // زيادة التباعد قليلاً
            ZStack {
                // الصورة القابلة للنقر
                Image(imageName)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 600, height: 400) // حجم يناسب الشاشة
                    .shadow(radius: 15)
                    .clipShape(RoundedRectangle(cornerRadius: 15))

                // جعل الصورة تعرض الفيديو عند الضغط
                Button(action: {
                    playVideo(videoName: videoName)
                }) {
                    Image(systemName: "play.circle.fill") // أيقونة التشغيل
                        .resizable()
                        .scaledToFit()
                        .frame(width: 60, height: 60)
                        .foregroundColor(.white)
                        .background(Circle().fill(Color.black.opacity(0.7)))
                }
            }

            // عنوان القصة
            Text(title)
                .multilineTextAlignment(.center)
                .foregroundColor(.black)
                .font(.custom("SF Arabic", size: 40)) // تكبير حجم الخط
                .shadow(radius: 5)
                .fontWeight(.bold)
        }
        
    }

    private func playVideo(videoName: String) {
        if let videoURL = Bundle.main.url(forResource: videoName, withExtension: "mp4") {
            let player = AVPlayer(url: videoURL)
            let playerController = AVPlayerViewController()
            playerController.player = player

            // عرض الفيديو باستخدام UIWindowScene
            if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
               let rootVC = windowScene.windows.first?.rootViewController {
                rootVC.present(playerController, animated: true) {
                    player.play()
                }
            }
        } else {
            print("الفيديو غير متوفر")
        }
    }
}

#Preview {
    MainContentView()
}
