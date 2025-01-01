//
//  LogInPage.swift
//  MyStory
//
//  Created by Raghad on 02/07/1446 AH.
//

//import SwiftUI
//import SwiftData
//
//struct LogInPage: View {
//    @State private var email = ""
//    @State private var password = ""
//    @State private var isAuthenticated = false // للتحقق من حالة تسجيل الدخول
//    
//    var body: some View {
//        NavigationStack {
//            ZStack {
//                Image("Background") // الخلفية
//                    .resizable()
//                    .scaledToFill()
//                    .ignoresSafeArea()
//                
//                VStack {
//                    Image("Logo")
//                        .resizable()
//                        .scaledToFit()
//                        .frame(width: 150, height: 150)
//                        .padding(.bottom, 40)
//                    
//                    TextField("البريد الإلكتروني", text: $email)
//                        .textFieldStyle(.roundedBorder)
//                        .padding()
//                        .autocapitalization(.none)
//                    
//                    SecureField("كلمة المرور", text: $password)
//                        .textFieldStyle(.roundedBorder)
//                        .padding()
//                    
//                    Button(action: {
//                        authenticateUser(email: email, password: password)
//                    }) {
//                        Text("تسجيل الدخول")
//                            .frame(maxWidth: .infinity)
//                            .padding()
//                            .background(Color.blue)
//                            .foregroundColor(.white)
//                            .cornerRadius(10)
//                            .shadow(radius: 5)
//                    }
//                    .padding(.top, 20)
//                    
//                    if isAuthenticated {
//                        NavigationLink(destination: Splash(), isActive: $isAuthenticated) {
//                            Splash()
//                        }
//                    }
//                }
//                .padding()
//            }
//        }
//    }
//    
//    private func authenticateUser(email: String, password: String) {
//        // تحقق من صحة البيانات (يمكنك استخدام SwiftData هنا للتحقق)
//        if email == "user@example.com" && password == "password" {
//            isAuthenticated = true
//        } else {
//            // عرض رسالة خطأ (يمكن تحسينها لاحقًا)
//            print("بيانات غير صحيحة")
//        }
//    }
//}
//
