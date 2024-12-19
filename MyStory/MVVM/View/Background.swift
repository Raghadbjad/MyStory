//
//  Background.swift
//  MyStory
//
//  Created by Raghad on 18/06/1446 AH.
//

import SwiftUI
struct Background: View {
    @State private var selectedBackground = "Background" // الخلفية الافتراضية
    
    var body: some View {
        NavigationStack {
            ZStack {
                Image("Background") // الخلفية الافتراضية
                    .resizable()
                    .scaledToFill()
                    .ignoresSafeArea()

                VStack {
                    
                    Text(" أختر خلفيتك ")
                        .font(.custom("SF Arabic", size: 50))
                        .shadow(radius: 15)
                        .multilineTextAlignment(.center)
                        .fontWeight(.bold)
                        .foregroundColor(.black)
                    
                    
                    HStack(spacing: 50) {
                        // الخيار الأول
                        NavigationLink(destination: Emotion(selectedCharacter: .constant(nil), selectedBackground: $selectedBackground)
                                        .onAppear {
                                            selectedBackground = "School" // تعيين الخلفية عند التنقل
                                            print("تم اختيار الخلفية: \(selectedBackground)") // اختبار القيمة
                                        }) {
                            ZStack {
                                RoundedRectangle(cornerRadius: 15)
                                    .fill(Color.white)
                                    .frame(width: 420, height: 440)
                                    .shadow(radius: 5)
                                    .overlay(
                                        RoundedRectangle(cornerRadius: 15)
                                            .stroke(Color.black, lineWidth: 1)
                                    )
                                VStack {
                                    Image("School")
                                        .resizable()
                                        .scaledToFit()
                                        .cornerRadius(20)
                                        .frame(width: 370, height: 360)
                                    Text("مدرسة")
                                        .font(.title)
                                        .foregroundColor(.black)
                                        .padding(.bottom, 40)
                                }
                            }
                        }
                        
                        // الخيار الثاني
                        NavigationLink(destination: Emotion(selectedCharacter: .constant(nil), selectedBackground: $selectedBackground)
                                        .onAppear {
                                            selectedBackground = "Home" // تعيين الخلفية عند التنقل
                                            print("تم اختيار الخلفية: \(selectedBackground)") // اختبار القيمة
                                        }) {
                            ZStack {
                                RoundedRectangle(cornerRadius: 15)
                                    .fill(Color.white)
                                    .frame(width: 420, height: 440)
                                    .shadow(radius: 5)
                                    .overlay(
                                        RoundedRectangle(cornerRadius: 15)
                                            .stroke(Color.black, lineWidth: 1)
                                    )
                                VStack {
                                    Image("Home")
                                        .resizable()
                                        .scaledToFit()
                                        .cornerRadius(20)
                                        .frame(width: 400, height: 400)
                                    Text("منزل")
                                        .font(.title)
                                        .foregroundColor(.black)
                                        .padding(.bottom, 40)
                                }
                            }
                        }
                    }
                    .padding()
                }
            }
        }
    }
}

#Preview {
    Background()
}
