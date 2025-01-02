//
//  LogInPage.swift
//  MyStory
//
//  Created by Raghad on 02/07/1446 AH.
//
//


//import SwiftUI
//import SwiftData
//
//struct LogInPage: View {
//    @Environment(\.modelContext) private var context
//    @Query private var users: [User]  // استرجاع جميع المستخدمين المحفوظين
//    @State private var userName = ""
//    @State private var password = ""
//    @State private var isAuthenticated = false
//    @State private var errorMessage = ""
//
//    var body: some View {
//        NavigationStack {
//            ZStack {
//                Image("Background") // الخلفية
//                    .resizable()
//                    .scaledToFill()
//                    .ignoresSafeArea()
//                
//                VStack(spacing: 20) {
//                    // الشعار
//                    Image("Logo")
//                        .resizable()
//                        .scaledToFit()
//                        .frame(width: 250, height: 250)
//                        .padding(.bottom, 30)
//                    
//                    // العنوان
//                    Text("تسجيل الدخول")
//                        .font(.title2)
//                        .fontWeight(.semibold)
//                        .foregroundColor(.black)
//                        .padding(.bottom, 20)
//                    
//                    // حقول الإدخال
//                    VStack(spacing: 15) {
//                        TextField("اسم المستخدم", text: $userName)
//                            .multilineTextAlignment(.center) // يجعل النص في المنتصف
//                            .padding()
//                            .frame(width: 400, height: 45)
//                            .background(Color.white)
//                            .cornerRadius(10)
//                            .shadow(radius: 2)
//                            .autocapitalization(.none)
//                        
//                        SecureField("كلمة المرور", text: $password)
//                            .multilineTextAlignment(.center) // يجعل النص في المنتصف
//                            .padding()
//                            .frame(width: 400, height: 45)
//                            .background(Color.white)
//                            .cornerRadius(10)
//                            .shadow(radius: 2)
//                    }
//                    
//                    // رسالة الخطأ
//                    if !errorMessage.isEmpty {
//                        Text(errorMessage)
//                            .foregroundColor(.red)
//                            .font(.footnote)
//                            .padding(.top, 5)
//                    }
//                    
//                    // زر تسجيل الدخول
//                    Button(action: {
//                        authenticateUser(userName: userName, password: password)
//                    }) {
//                        Text("تسجيل الدخول")
//                            .frame(width: 400, height: 45)
//                            .background(Color("LightBlue")) // لون الزر بيبي بلو
//                            .foregroundColor(.black)
//                            .cornerRadius(10)
//                            .shadow(radius: 2)
//                    }
//                    .padding(.top, 20)
//                    
//                    // رابط إنشاء حساب جديد
//                    NavigationLink(destination: LogUpPage(), label: {
//                        Text("إنشاء حساب جديد")
//                            .bold()
//                            .font(.footnote)
//                            .foregroundColor(.blue)
//                            .padding(.top, 10)
//                    })
//                    
//                    // التنقل في حالة نجاح تسجيل الدخول
//                    if isAuthenticated {
//                        NavigationLink(destination: Splash(), isActive: $isAuthenticated) {
//                            EmptyView()
//                        }
//                    }
//                }
//                .padding()
//            }
//        }
//    }
//
//    private func authenticateUser(userName: String, password: String) {
//        if let user = users.first(where: { $0.userName == userName && $0.password == password }) {
//            isAuthenticated = true
//        } else {
//            errorMessage = "اسم المستخدم أو كلمة المرور غير صحيحة."
//        }
//    }
//}

import SwiftUI
import SwiftData

struct LogInPage: View {
    @Environment(\.modelContext) private var context
    @Query private var users: [User]  // استرجاع جميع المستخدمين المحفوظين
    @State private var userName = ""
    @State private var password = ""
    @State private var isAuthenticated = false
    @State private var errorMessage = ""

    var body: some View {
        NavigationStack {
            ZStack {
                Image("Background") // الخلفية
                    .resizable()
                    .scaledToFill()
                    .ignoresSafeArea()
                
                VStack(spacing: 20) {
                    // الشعار
                    Image("Logo")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 250, height: 250)
                        .padding(.bottom, 30)
                    
                    // العنوان
                    Text("تسجيل الدخول")
                        .font(.title2)
                        .fontWeight(.semibold)
                        .foregroundColor(.black)
                        .padding(.bottom, 20)
                    
                    // حقول الإدخال
                    VStack(spacing: 15) {
                        TextField("اسم المستخدم", text: $userName)
                            .multilineTextAlignment(.center) // يجعل النص في المنتصف
                            .padding()
                            .frame(width: 400, height: 45)
                            .background(Color.white)
                            .cornerRadius(10)
                            .shadow(radius: 2)
                            .autocapitalization(.none)
                            .foregroundColor(.black) // تحديد لون النص داخل الحقل

                        SecureField("كلمة المرور", text: $password)
                            .multilineTextAlignment(.center) // يجعل النص في المنتصف
                            .padding()
                            .frame(width: 400, height: 45)
                            .background(Color.white)
                            .cornerRadius(10)
                            .shadow(radius: 2)
                            .foregroundColor(.black) // تحديد لون النص داخل الحقل
                    }
                    
                    // رسالة الخطأ
                    if !errorMessage.isEmpty {
                        Text(errorMessage)
                            .foregroundColor(.red)
                            .font(.footnote)
                            .padding(.top, 5)
                    }
                    
                    // زر تسجيل الدخول
                    Button(action: {
                        authenticateUser(userName: userName, password: password)
                    }) {
                        Text("تسجيل الدخول")
                            .frame(width: 400, height: 45)
                            .background(Color("LightBlue")) // لون الزر بيبي بلو
                            .foregroundColor(.black)
                            .cornerRadius(10)
                            .shadow(radius: 2)
                    }
                    .padding(.top, 20)
                    
                    // رابط إنشاء حساب جديد
                    NavigationLink(destination: LogUpPage(), label: {
                        Text("إنشاء حساب جديد")
                            .bold()
                            .font(.footnote)
                            .foregroundColor(.blue)
                            .padding(.top, 10)
                    })
                    
                    // التنقل في حالة نجاح تسجيل الدخول
                    if isAuthenticated {
                        NavigationLink(destination: Splash(), isActive: $isAuthenticated) {
                            EmptyView()
                        }
                    }
                }
                .padding()
            }
        }
    }

    private func authenticateUser(userName: String, password: String) {
        if let user = users.first(where: { $0.userName == userName && $0.password == password }) {
            isAuthenticated = true
        } else {
            errorMessage = "اسم المستخدم أو كلمة المرور غير صحيحة."
        }
    }
}
