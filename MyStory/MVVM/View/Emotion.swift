//
//  Emotion.swift
//  MyStory
//
//  Created by Raghad on 18/06/1446 AH.
//

import SwiftUI
import Photos
import AVFoundation
import UIKit
import _AVKit_SwiftUI
import SwiftData
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
import AVKit

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
            Image(selectedBackground) // الخلفية المختارة
                .resizable()
                .scaledToFill()
                .ignoresSafeArea()

            VStack {
                Spacer()
                HStack {
                    Image(character)
                        .resizable()
                        .scaledToFit()
                        .frame(width: 500, height: 500)
                    Spacer()
                }
                .padding(.bottom, 1)

                VStack {
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
                    }
                    .padding()

                    Button(action: {
                        if self.isPlaying {
                            self.stopPlayback()
                        } else {
                            self.startPlayback()
                        }
                    }) {
                        Text(isPlaying ? "Stop Playback" : "Play Recording")
                            .font(.headline)
                            .padding()
                            .background(Color.blue)
                            .foregroundColor(.white)
                            .cornerRadius(10)
                    }

//                    Button(action: {
//                        self.showOverlay = true // إظهار الشاشة السوداء
//                    }) {
//                        Text("Show Overlay")
//                            .font(.headline)
//                            .padding()
//                            .background(Color.green)
//                            .foregroundColor(.white)
//                            .cornerRadius(10)
//                    }
                }
                .padding(.bottom, 20)
            }

            // الشاشة السوداء الشفافة
            if showOverlay {
                Color.black.opacity(0.6)
                    .ignoresSafeArea()
                    .overlay(
                        VStack(spacing: 20) {
                            Button("العودة للصفحة الرئيسية") {
                                
                                // قم بإعادة التوجيه إلى الصفحة الرئيسية
                            }
                            .padding()
                            .background(Color.white)
                            .cornerRadius(10)
                            .foregroundColor(.black)

                            Button("إعادة تشغيل الصفحة") {
                                self.showOverlay = false // إخفاء الشاشة السوداء
                            }
                            .padding()
                            .background(Color.white)
                            .cornerRadius(10)
                            .foregroundColor(.black)
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

        if audioURL == nil { // إذا لم يكن هناك تسجيل سابق
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
