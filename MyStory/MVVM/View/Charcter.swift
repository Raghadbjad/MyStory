//
//  Charcter.swift
//  MyStory
//
//  Created by Raghad on 17/06/1446 AH.
//

import SwiftUI
import SwiftData
struct Charcter: View {
    var body: some View {
        NavigationStack {
            ZStack {
                Image("Background")
                    .resizable()
                    .scaledToFill()
                    .ignoresSafeArea()

                VStack {
                    HStack(spacing: 50) {
                        VStack {
                            NavigationLink(destination: Main()) {
                                ZStack {
                                    
                                    RoundedRectangle(cornerRadius: 15)
                                        .fill(Color.white)
                                        .frame(width: 420, height: 440) // حجم المستطيل
                                        .shadow(radius: 5) // ظل المستطيل
                                        .overlay( // إضافة الحدود السوداء
                                        RoundedRectangle(cornerRadius: 15)
                                        .stroke(Color.black, lineWidth: 1)  )
                                    VStack{
                                        
                                        
                                        Image("BoyCharcter")
                                            .resizable()
                                            .scaledToFit()
                                            .frame(width: 350, height: 350) // حجم الصورة داخل المستطيل
                                        Text("ولد")
                                            .font(.custom("SF Arabic", size: 40))
                                            .shadow(radius: 15)
                                            .multilineTextAlignment(.center)
                                            .fontWeight(.bold)
                                            .foregroundColor(.black)
                                            .padding(.top, 5)
                                        
                                    }
                                }
                            }
                        }

                        VStack {
                            NavigationLink(destination: Main()) {
                                ZStack {
                                    RoundedRectangle(cornerRadius: 15)
                                        .fill(Color.white)
                                        .frame(width: 420, height: 440) // حجم المستطيل
                                        .shadow(radius: 5) // ظل المستطيل
                                        .overlay( // إضافة الحدود السوداء
                                        RoundedRectangle(cornerRadius: 15)
                                        .stroke(Color.black, lineWidth: 1)  )
                                    VStack{
                                        Image("GirlCharcter")
                                            .resizable()
                                            .scaledToFit()
                                            .cornerRadius(24)
                                            .frame(width: 330, height: 330) // حجم الصورة داخل
                                        Text("بنت")
                                            .font(.custom("SF Arabic", size: 40))
                                            .shadow(radius: 15)
                                            .multilineTextAlignment(.center)
                                            .fontWeight(.bold)
                                            .foregroundColor(.black)
                                            .padding(.top, 5) }}
                                
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
    Charcter()
}



