//
//  Emotion.swift
//  MyStory
//
//  Created by Raghad on 18/06/1446 AH.

struct Emotion: View {
    @Binding var selectedCharacter: String
    @Binding var selectedBackground: String

    var body: some View {
        NavigationStack {
            ZStack {
                Image("Background")
                    .resizable()
                    .scaledToFill()
                    .ignoresSafeArea()
                
                VStack {
                    Text("ماذا تشعر ؟")
                        .font(.custom("SF Arabic", size: 55))
                        .shadow(radius: 15)
                        .multilineTextAlignment(.center)
                        .fontWeight(.bold)

                    HStack(spacing: 10) {
                        VStack {
                            NavigationLink(destination: CharacterPage(character: "HappyBoy", selectedCharacter: $selectedCharacter, selectedBackground: $selectedBackground)
                                            .onAppear {
                                                selectedCharacter = "HappyBoy" // تعيين الشخصية المختارة
                                                print("تم اختيار الشخصية: \(selectedCharacter)") // اختبار القيمة
                                            }) {
                                characterSelectionCard(imageName: "HappyBoy", label: "سعيد")
                            }


                        }
                        NavigationLink(destination: CharacterPage(character: "AngryBoy", selectedCharacter: $selectedCharacter, selectedBackground: $selectedBackground)
                                        .onAppear {
                                            selectedCharacter = "AngryBoy" // تعيين الشخصية المختارة
                                            print("تم اختيار الشخصية: \(selectedCharacter)") // اختبار القيمة
                                        }) {
                            characterSelectionCard(imageName: "AngryBoy", label: "غاضب")
                        }

                        NavigationLink(destination: CharacterPage(character: "SurprisedBoy", selectedCharacter: $selectedCharacter, selectedBackground: $selectedBackground)
                                        .onAppear {
                                            selectedCharacter = "SurprisedBoy" // تعيين الشخصية المختارة
                                            print("تم اختيار الشخصية: \(selectedCharacter)") // اختبار القيمة
                                        }) {
                            characterSelectionCard(imageName: "SurprisedBoy", label: "متفاجئ")
                        }

                        NavigationLink(destination: CharacterPage(character: "SadBoy", selectedCharacter: $selectedCharacter, selectedBackground: $selectedBackground)
                                        .onAppear {
                                            selectedCharacter = "SadBoy" // تعيين الشخصية المختارة
                                            print("تم اختيار الشخصية: \(selectedCharacter)") // اختبار القيمة
                                        }) {
                            characterSelectionCard(imageName: "SadBoy", label: "حزين")
                        }
                    }
                    .padding()
                }
            }
        }
    }

    func characterSelectionCard(imageName: String, label: String) -> some View {
        ZStack {
            RoundedRectangle(cornerRadius: 15)
                .fill(Color.white)
                .frame(width: 300, height: 400)
                .shadow(radius: 5)
                .overlay(RoundedRectangle(cornerRadius: 15).stroke(Color.black, lineWidth: 1))
            VStack {
                Image(imageName)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 300, height: 300)
                Text(label)
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


import SwiftUI
import AVFoundation

struct CharacterPage: View {
    var character: String
    @Binding var selectedCharacter: String
    @Binding var selectedBackground: String
    @State private var isRecording = false
    @State private var isPlaying = false
    @State private var audioURL: URL?
    @State private var recorder: AVAudioRecorder?
    @State private var player: AVAudioPlayer?
    @State private var showOverlay = false // لإظهار الشاشة السوداء الشفافة

    private let audioDelegate = AudioPlayerDelegateHandler()

    var body: some View {
        ZStack {
            // الخلفية المختارة
            Image(selectedBackground)
                .resizable()
                .scaledToFill()
                .ignoresSafeArea()

            // زر التسجيل في الزاوية اليمنى العليا
            VStack {
                HStack {
                    Spacer()
                    Button(action: {
                        if self.isRecording {
                            self.stopRecording()
                        } else {
                            self.startRecording()
                        }
                    }) {
                        Image(isRecording ? "Record" : "RecordOff")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 80, height: 80)
                            .shadow(radius: 20)
                            .padding()
                    }
                }
                Spacer()
            }
            
            // الكاركتر على يسار الشاشة
            VStack {
                Spacer()
                HStack {
                    Image(character)
                        .resizable()
                        .scaledToFit()
                        .shadow(radius: 40)
                        .frame(width: 500, height: 600) // حجم الكاركتر
                        .offset(x: -20, y: 20) // محاذاة نحو الأرض
                    Spacer()
                }
            }

            // زر تشغيل التسجيل في أسفل يمين الشاشة
            if !isRecording && audioURL != nil {
                VStack {
                    Spacer() // يجعل الزر في أسفل الشاشة
                    HStack {
                        Spacer() // يجعل الزر في اليمين
                        Button(action: {
                            if self.isPlaying {
                                self.stopPlayback()
                            } else {
                                self.startPlayback()
                            }
                        }) {
                            Image(systemName: isPlaying ? "stop.fill" : "play.fill") // أيقونة التشغيل/الإيقاف
                                .font(.system(size: 150)) // حجم الأيقونة أكبر
                                .foregroundColor(.white)
                                .padding()
                                .shadow(radius: 20)
                                .background(Color.lightBlue)
                                .clipShape(Circle())
                        }
                        .padding(.bottom, 20)
                        .padding(.horizontal , 20)// إضافة مسافة من الأسفل
                    }
                }
            }

            // الشاشة السوداء الشفافة
            if showOverlay {
                Color.black.opacity(0.6)
                    .ignoresSafeArea()
                    .overlay(
                        HStack(spacing: 20) {
                            NavigationLink(destination: Main()) { // الربط مع صفحة Main
                                Image(systemName: "house.fill") // أيقونة البيت
                                    .font(.system(size: 50))
                                    .foregroundColor(.white)
                                    .shadow(radius: 20)
                                    .padding()
                                    .background(Color.lightBlue)
                                    .clipShape(Circle())
                            }

                            Button(action: {
                                self.showOverlay = false // إخفاء الشاشة السوداء
                            }) {
                                Image(systemName: "arrow.clockwise") // أيقونة الإعادة
                                    .font(.system(size: 50))
                                    .shadow(radius: 20)
                                    .foregroundColor(.white)
                                    .padding()
                                    .background(Color.lightBlue)
                                    .clipShape(Circle())
                            }
                        }
                        .padding()
                    )
            }
        }
    }

    func startRecording() {
        let audioSession = AVAudioSession.sharedInstance()
        try? audioSession.setCategory(.playAndRecord, mode: .default)
        try? audioSession.setActive(true, options: .notifyOthersOnDeactivation)

        if audioURL == nil {
            let fileName = "audio.m4a"
            let filePath = FileManager.default.temporaryDirectory.appendingPathComponent(fileName)
            audioURL = filePath
        }

        let settings: [String: Any] = [
            AVFormatIDKey: Int(kAudioFormatMPEG4AAC),
            AVSampleRateKey: 12000,
            AVNumberOfChannelsKey: 1,
            AVEncoderAudioQualityKey: AVAudioQuality.high.rawValue
        ]

        do {
            recorder = try AVAudioRecorder(url: audioURL!, settings: settings)
            recorder?.record()
            isRecording = true
        } catch {
            print("Error starting recording: \(error)")
        }
    }

    func stopRecording() {
        recorder?.stop()
        isRecording = false
    }

    func startPlayback() {
        guard let audioURL = audioURL else {
            print("No audio file available to play.")
            return
        }

        do {
            player = try AVAudioPlayer(contentsOf: audioURL)
            player?.delegate = audioDelegate
            audioDelegate.onFinish = {
                self.isPlaying = false
                self.showOverlay = true // إظهار الشاشة السوداء
            }
            player?.play()
            isPlaying = true
            
        } catch {
            print("Error playing audio: \(error)")
        }
    }

    func stopPlayback() {
        player?.stop()
        isPlaying = false
    }
}

class AudioPlayerDelegateHandler: NSObject, AVAudioPlayerDelegate {
    var onFinish: (() -> Void)?

    func audioPlayerDidFinishPlaying(_ player: AVAudioPlayer, successfully flag: Bool) {
        onFinish?()
    }
}

