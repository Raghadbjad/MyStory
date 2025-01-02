//
//  LogUpPage.swift
//  MyStory
//
//  Created by Raghad on 02/07/1446 AH.
//


import SwiftUI
import SwiftData
//
//struct LogUpPage: View {
//    @Environment(\.modelContext) private var context
//    @State private var userName = ""
//    @State private var password = ""
//    @State private var confirmPassword = ""
//    @State private var isSignedUp = false
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
//                    Text("إنشاء حساب")
//                        .font(.title2)
//                        .fontWeight(.semibold)
//                        .foregroundColor(.black)
//                        .padding(.bottom, 20)
//                    
//                    // حقول الإدخال
//                    VStack(spacing: 15) {
//                        TextField("اسم المستخدم", text: $userName)
//                            .multilineTextAlignment(.center)
//                            .padding()
//                            .frame(width: 400, height: 45)
//                            .background(Color.white)
//                            .cornerRadius(10)
//                            .shadow(radius: 2)
//                            .autocapitalization(.none)
//                        
//                        SecureField("كلمة المرور", text: $password)
//                            .multilineTextAlignment(.center)
//                            .padding()
//                            .frame(width: 400, height: 45)
//                            .background(Color.white)
//                            .cornerRadius(10)
//                            .shadow(radius: 2)
//                        
//                        SecureField("تأكيد كلمة المرور", text: $confirmPassword)
//                            .multilineTextAlignment(.center)
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
//                    // زر إنشاء الحساب
//                    Button(action: {
//                        signUpUser(userName: userName, password: password, confirmPassword: confirmPassword)
//                    }) {
//                        Text("إنشاء حساب")
//                            .frame(width: 400, height: 45)
//                            .background(Color.blue)
//                            .foregroundColor(.white)
//                            .cornerRadius(10)
//                            .shadow(radius: 2)
//                    }
//                    .padding(.top, 20)
//                    
//                    // التنقل في حالة نجاح تسجيل الحساب
//                    NavigationLink(destination: Splash(), isActive: $isSignedUp) {
//                        EmptyView()
//                    }
//                }
//                .padding()
//            }
//        }
//    }
//    
//    private func signUpUser(userName: String, password: String, confirmPassword: String) {
//        if userName.isEmpty || password.isEmpty || confirmPassword.isEmpty {
//            errorMessage = "جميع الحقول مطلوبة."
//        } else if password != confirmPassword {
//            errorMessage = "كلمات المرور غير متطابقة."
//        } else if password.count < 8 {
//            errorMessage = "كلمة المرور يجب أن تكون على الأقل 8 أحرف."
//        } else if !isValidPassword(password) {
//            errorMessage = "كلمة المرور يجب أن تحتوي على أحرف كبيرة، أحرف صغيرة، وأرقام."
//        } else {
//            let newUser = User(userName: userName, password: password)
//            context.insert(newUser)
//            // تأكد من التحديث على UI بعد إضافة المستخدم
//            DispatchQueue.main.async {
//                isSignedUp = true
//            }
//        }
//    }
//    
//    // تحقق من قوة كلمة المرور (حروف كبيرة، حروف صغيرة، أرقام)
//    private func isValidPassword(_ password: String) -> Bool {
//        let passwordRegex = "(?=.*[a-z])(?=.*[A-Z])(?=.*[0-9]).{8,}"
//        let passwordPredicate = NSPredicate(format: "SELF MATCHES %@", passwordRegex)
//        return passwordPredicate.evaluate(with: password)
//    }
//}

struct LogUpPage: View {
    @Environment(\.modelContext) private var context
    @State private var userName = ""
    @State private var password = ""
    @State private var confirmPassword = ""
    @State private var isSignedUp = false
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
                    Text("إنشاء حساب")
                        .font(.title2)
                        .fontWeight(.semibold)
                        .foregroundColor(.black)
                        .padding(.bottom, 20)
                    
                    // حقول الإدخال
                    VStack(spacing: 15) {
                        TextField("اسم المستخدم", text: $userName)
                            .multilineTextAlignment(.center)
                            .padding()
                            .frame(width: 400, height: 45)
                            .background(Color.white)
                            .cornerRadius(10)
                            .shadow(radius: 2)
                            .autocapitalization(.none)
                            .foregroundColor(.black)  // تحديد لون النص داخل حقل النص

                        SecureField("كلمة المرور", text: $password)
                            .multilineTextAlignment(.center)
                            .padding()
                            .frame(width: 400, height: 45)
                            .background(Color.white)
                            .cornerRadius(10)
                            .shadow(radius: 2)
                            .foregroundColor(.black)  // تحديد لون النص داخل حقل كلمة المرور

                        SecureField("تأكيد كلمة المرور", text: $confirmPassword)
                            .multilineTextAlignment(.center)
                            .padding()
                            .frame(width: 400, height: 45)
                            .background(Color.white)
                            .cornerRadius(10)
                            .shadow(radius: 2)
                            .foregroundColor(.black)  // تحديد لون النص داخل حقل تأكيد كلمة المرور
                    }
                    
                    // رسالة الخطأ
                    if !errorMessage.isEmpty {
                        Text(errorMessage)
                            .foregroundColor(.red)
                            .font(.footnote)
                            .padding(.top, 5)
                    }
                    
                    // زر إنشاء الحساب
                    Button(action: {
                        signUpUser(userName: userName, password: password, confirmPassword: confirmPassword)
                    }) {
                        Text("إنشاء حساب")
                            .frame(width: 400, height: 45)
                            .background(Color.blue)
                            .foregroundColor(.white)
                            .cornerRadius(10)
                            .shadow(radius: 2)
                    }
                    .padding(.top, 20)
                    
                    // التنقل في حالة نجاح تسجيل الحساب
                    NavigationLink(destination: Splash(), isActive: $isSignedUp) {
                        EmptyView()
                    }
                }
                .padding()
            }
        }
    }
    
    private func signUpUser(userName: String, password: String, confirmPassword: String) {
        if userName.isEmpty || password.isEmpty || confirmPassword.isEmpty {
            errorMessage = "جميع الحقول مطلوبة."
        } else if password != confirmPassword {
            errorMessage = "كلمات المرور غير متطابقة."
        } else if password.count < 8 {
            errorMessage = "كلمة المرور يجب أن تكون على الأقل 8 أحرف."
        } else if !isValidPassword(password) {
            errorMessage = "كلمة المرور يجب أن تحتوي على أحرف كبيرة، أحرف صغيرة، وأرقام."
        } else {
            let newUser = User(userName: userName, password: password)
            context.insert(newUser)
            // تأكد من التحديث على UI بعد إضافة المستخدم
            DispatchQueue.main.async {
                isSignedUp = true
            }
        }
    }
    
    // تحقق من قوة كلمة المرور (حروف كبيرة، حروف صغيرة، أرقام)
    private func isValidPassword(_ password: String) -> Bool {
        let passwordRegex = "(?=.*[a-z])(?=.*[A-Z])(?=.*[0-9]).{8,}"
        let passwordPredicate = NSPredicate(format: "SELF MATCHES %@", passwordRegex)
        return passwordPredicate.evaluate(with: password)
    }
}

