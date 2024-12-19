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

struct Emotion: View {
    @Binding var selectedCharacter: String?
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
                            NavigationLink(destination: CharacterPage(character: "HappyBoy", selectedCharacter: $selectedCharacter, selectedBackground: $selectedBackground)) {
                                characterSelectionCard(imageName: "HappyBoy", label: "سعيد")
                            }
                        }
                        VStack {
                            NavigationLink(destination: CharacterPage(character: "AngryBoy", selectedCharacter: $selectedCharacter, selectedBackground: $selectedBackground)) {
                                characterSelectionCard(imageName: "AngryBoy", label: "غاضب")
                            }
                        }
                        VStack {
                            NavigationLink(destination: CharacterPage(character: "SurprisedBoy", selectedCharacter: $selectedCharacter, selectedBackground: $selectedBackground)) {
                                characterSelectionCard(imageName: "SurprisedBoy", label: "متفاجئ")
                            }
                        }
                        VStack {
                            NavigationLink(destination: CharacterPage(character: "SadBoy", selectedCharacter: $selectedCharacter, selectedBackground: $selectedBackground)) {
                                characterSelectionCard(imageName: "SadBoy", label: "حزين")
                            }
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


struct CharacterPage: View {
    var character: String
    @Binding var selectedCharacter: String?
    @Binding var selectedBackground: String
    @State private var isRecording = false
    @State private var audioURL: URL?
    @State private var recorder: AVAudioRecorder?
    @State private var showReviewPage = false
    @State private var videoURL: URL?

    var body: some View {
        ZStack {
            Image(selectedBackground)
                .resizable()
                .scaledToFill()
                .ignoresSafeArea()

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
                            .frame(width: 70, height: 70)
                    }
                    .padding(.top, 20)
                    .padding(.trailing, 20)
                }
                Spacer()
                HStack {
                    Image(character)
                        .resizable()
                        .scaledToFit()
                        .frame(width: 600, height: 400)
                        .padding(.trailing, 20)
                    Spacer()
                }
                .padding(.bottom, 20)
            }

            NavigationLink(destination: ReviewPage(videoURL: videoURL), isActive: $showReviewPage) {
                EmptyView()
            }
        }
    }

    func startRecording() {
        let audioSession = AVAudioSession.sharedInstance()
        try? audioSession.setCategory(.playAndRecord, mode: .default)
        try? audioSession.setActive(true, options: .notifyOthersOnDeactivation)

        let fileName = "audio.m4a"
        let filePath = FileManager.default.temporaryDirectory.appendingPathComponent(fileName)

        let settings: [String: Any] = [
            AVFormatIDKey: Int(kAudioFormatMPEG4AAC),
            AVSampleRateKey: 12000,
            AVNumberOfChannelsKey: 1,
            AVEncoderAudioQualityKey: AVAudioQuality.high.rawValue
        ]

        do {
            recorder = try AVAudioRecorder(url: filePath, settings: settings)
            recorder?.record()
            audioURL = filePath
            isRecording = true
        } catch {
            print("Error starting recording: \(error)")
        }
    }

    // إيقاف التسجيل
    func stopRecording() {
        recorder?.stop()
        isRecording = false

        if let audioURL = audioURL {
            createVideo(with: audioURL) { url in
                self.videoURL = url
                self.showReviewPage = true
            }
        }
    }

    func createVideo(with audioURL: URL, completion: @escaping (URL?) -> Void) {
        let videoSize = CGSize(width: 1080, height: 1920)
        let outputURL = FileManager.default.temporaryDirectory.appendingPathComponent("video.mp4")

        let videoWriter = try? AVAssetWriter(outputURL: outputURL, fileType: .mp4)
        let videoSettings: [String: Any] = [
            AVVideoCodecKey: AVVideoCodecType.h264,
            AVVideoWidthKey: videoSize.width,
            AVVideoHeightKey: videoSize.height
        ]

        let writerInput = AVAssetWriterInput(mediaType: .video, outputSettings: videoSettings)
        let pixelBufferAdaptor = AVAssetWriterInputPixelBufferAdaptor(
            assetWriterInput: writerInput,
            sourcePixelBufferAttributes: [
                kCVPixelBufferPixelFormatTypeKey as String: kCVPixelFormatType_32ARGB,
                kCVPixelBufferWidthKey as String: videoSize.width,
                kCVPixelBufferHeightKey as String: videoSize.height
            ]
        )

        videoWriter?.add(writerInput)
        videoWriter?.startWriting()
        videoWriter?.startSession(atSourceTime: .zero)

        let displayDuration: CMTime = CMTime(seconds: 5, preferredTimescale: 600)
        let frameDuration: CMTime = CMTime(value: 1, timescale: 30)
        let backgroundImage = UIImage(named: selectedBackground)!
        let characterImage = UIImage(named: character)!

        let combinedImage = combineImages(background: backgroundImage, character: characterImage, size: videoSize)

        var frameCount: Int64 = 0
        let queue = DispatchQueue(label: "videoQueue")
        writerInput.requestMediaDataWhenReady(on: queue) {
            while writerInput.isReadyForMoreMediaData {
                if frameCount >= Int64(displayDuration.value / frameDuration.value) {
                    writerInput.markAsFinished()
                    videoWriter?.finishWriting {
                        mergeAudioWithVideo(videoURL: outputURL, audioURL: audioURL) { finalURL in
                            completion(finalURL)
                        }
                    }
                    break
                }

                if let pixelBuffer = createPixelBuffer(from: combinedImage, size: videoSize) {
                    pixelBufferAdaptor.append(pixelBuffer, withPresentationTime: CMTime(value: frameCount, timescale: frameDuration.timescale))
                    frameCount += 1
                }
            }
        }
    }

    func combineImages(background: UIImage, character: UIImage, size: CGSize) -> UIImage {
        UIGraphicsBeginImageContext(size)
        background.draw(in: CGRect(origin: .zero, size: size))
        character.draw(in: CGRect(x: size.width / 4, y: size.height / 4, width: size.width / 2, height: size.height / 2))
        let combinedImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return combinedImage ?? background
    }

    func createPixelBuffer(from image: UIImage, size: CGSize) -> CVPixelBuffer? {
        let options: [String: Any] = [
            kCVPixelBufferCGImageCompatibilityKey as String: true,
            kCVPixelBufferCGBitmapContextCompatibilityKey as String: true
        ]

        var pixelBuffer: CVPixelBuffer?
        CVPixelBufferCreate(kCFAllocatorDefault, Int(size.width), Int(size.height), kCVPixelFormatType_32ARGB, options as CFDictionary, &pixelBuffer)

        guard let buffer = pixelBuffer else { return nil }

        CVPixelBufferLockBaseAddress(buffer, [])
        let context = CGContext(
            data: CVPixelBufferGetBaseAddress(buffer),
            width: Int(size.width),
            height: Int(size.height),
            bitsPerComponent: 8,
            bytesPerRow: CVPixelBufferGetBytesPerRow(buffer),
            space: CGColorSpaceCreateDeviceRGB(),
            bitmapInfo: CGImageAlphaInfo.noneSkipFirst.rawValue
        )

        guard let cgImage = image.cgImage else { return nil }

        context?.draw(cgImage, in: CGRect(origin: .zero, size: size))
        CVPixelBufferUnlockBaseAddress(buffer, [])

        return buffer
    }

    func mergeAudioWithVideo(videoURL: URL, audioURL: URL, completion: @escaping (URL?) -> Void) {
        let mixComposition = AVMutableComposition()

        guard
            let videoAsset = AVAsset(url: videoURL).tracks(withMediaType: .video).first,
            let audioAsset = AVAsset(url: audioURL).tracks(withMediaType: .audio).first
        else {
            completion(nil)
            return
        }

        let videoTrack = mixComposition.addMutableTrack(withMediaType: .video, preferredTrackID: kCMPersistentTrackID_Invalid)
        let audioTrack = mixComposition.addMutableTrack(withMediaType: .audio, preferredTrackID: kCMPersistentTrackID_Invalid)

        try? videoTrack?.insertTimeRange(CMTimeRange(start: .zero, duration: videoAsset.timeRange.duration), of: videoAsset, at: .zero)
        try? audioTrack?.insertTimeRange(CMTimeRange(start: .zero, duration: audioAsset.timeRange.duration), of: audioAsset, at: .zero)

        let outputURL = FileManager.default.temporaryDirectory.appendingPathComponent("mergedVideo.mp4")
        let exportSession = AVAssetExportSession(asset: mixComposition, presetName: AVAssetExportPresetHighestQuality)
        exportSession?.outputFileType = .mp4
        exportSession?.outputURL = outputURL
        exportSession?.exportAsynchronously {
            completion(exportSession?.status == .completed ? outputURL : nil)
        }
    }
}

