//
//  VideoCreator.swift
//  MyStory
//
//  Created by Raghad on 21/06/1446 AH.
//
//import AVFoundation
//import UIKit
//
//class VideoCreator {
//    
//    // الدالة الرئيسية لإنشاء الفيديو مع الصوت
//    func createVideoWithAudio(backgroundImage: UIImage, characterImage: UIImage, audioURL: URL, completion: @escaping (URL?) -> Void) {
//        
//        // إعدادات الفيديو
//        let videoSize = CGSize(width: 1920, height: 1080)
//        let videoURL = FileManager.default.temporaryDirectory.appendingPathComponent("output.mov")
//        
//        // إعداد AVAssetWriter للكتابة على الفيديو
//        do {
//            let writer = try AVAssetWriter(outputURL: videoURL, fileType: .mov)
//            let videoInput = createVideoInput(writer: writer, size: videoSize)
//            let audioInput = createAudioInput(writer: writer, url: audioURL)
//            
//            if writer.startWriting() {
//                writer.startSession(atSourceTime: .zero)
//                
//                // إعداد PixelBufferAdaptor قبل بدء الكتابة
//                let pixelBufferAdapter = AVAssetWriterInputPixelBufferAdaptor(assetWriterInput: videoInput, sourcePixelBufferAttributes: nil)
//                addFramesToVideo(videoInput: videoInput, pixelBufferAdapter: pixelBufferAdapter, frameDuration: CMTime(value: 1, timescale: 30), backgroundImage: backgroundImage, characterImage: characterImage, completion: {
//                    // انتهاء من الكتابة الصوتية
//                    audioInput?.markAsFinished()
//                    writer.finishWriting {
//                        if writer.status == .completed {
//                            completion(videoURL)
//                        } else {
//                            if let error = writer.error {
//                                print("خطأ في إنشاء الفيديو: \(error.localizedDescription)")
//                            } else {
//                                print("حدث خطأ غير معروف أثناء كتابة الفيديو.")
//                            }
//                            completion(nil)
//                        }
//                    }
//                })
//            } else {
//                // إذا فشل بدء الكتابة، طباعة رسالة الخطأ
//                if let error = writer.error {
//                    print("خطأ في بدء الكتابة: \(error.localizedDescription)")
//                } else {
//                    print("خطأ غير معروف في بدء الكتابة.")
//                }
//                completion(nil)
//            }
//        } catch {
//            print("خطأ في إنشاء AVAssetWriter: \(error.localizedDescription)")
//            completion(nil)
//        }
//    }
//    
//    // إنشاء AVAssetWriterInput للفيديو
//    func createVideoInput(writer: AVAssetWriter, size: CGSize) -> AVAssetWriterInput {
//        let videoSettings: [String: Any] = [
//            AVVideoCodecKey: AVVideoCodecType.h264,
//            AVVideoWidthKey: size.width,
//            AVVideoHeightKey: size.height
//        ]
//        
//        let videoInput = AVAssetWriterInput(mediaType: .video, outputSettings: videoSettings)
//        videoInput.expectsMediaDataInRealTime = true
//        
//        if !writer.canAdd(videoInput) {
//            print("لا يمكن إضافة مدخلات الفيديو")
//        }
//        
//        writer.add(videoInput)
//        return videoInput
//    }
//    
//    // إنشاء AVAssetWriterInput للصوت
//    func createAudioInput(writer: AVAssetWriter, url: URL) -> AVAssetWriterInput? {
//        let audioAsset = AVURLAsset(url: url)
//        guard let audioTrack = audioAsset.tracks(withMediaType: .audio).first else {
//            print("خطأ في إيجاد المسار الصوتي")
//            return nil
//        }
//        
//        let audioSettings: [String: Any] = [
//            AVFormatIDKey: kAudioFormatMPEG4AAC,
//            AVSampleRateKey: audioTrack.naturalTimeScale, // استخدام naturalTimeScale للحصول على معدل العينة
//            AVNumberOfChannelsKey: audioTrack.formatDescriptions.count
//        ]
//        
//        let audioInput = AVAssetWriterInput(mediaType: .audio, outputSettings: audioSettings)
//        audioInput.expectsMediaDataInRealTime = true
//        if writer.canAdd(audioInput) {
//            writer.add(audioInput)
//        } else {
//            print("غير قادر على إضافة مدخلات الصوت")
//            return nil
//        }
//        
//        return audioInput
//    }
//    
//    // إضافة الإطارات إلى الفيديو
//    func addFramesToVideo(videoInput: AVAssetWriterInput, pixelBufferAdapter: AVAssetWriterInputPixelBufferAdaptor, frameDuration: CMTime, backgroundImage: UIImage, characterImage: UIImage, completion: @escaping () -> Void) {
//        var frameTime = CMTime.zero
//        
//        for i in 0..<300 { // 10 ثواني فيديو (30 إطار في الثانية)
//            let currentBuffer = i < 150 ? pixelBuffer(from: backgroundImage) : pixelBuffer(from: characterImage)
//            if let buffer = currentBuffer {
//                if pixelBufferAdapter.append(buffer, withPresentationTime: frameTime) {
//                    frameTime = CMTimeAdd(frameTime, frameDuration)
//                } else {
//                    print("خطأ في إضافة الإطار إلى الفيديو")
//                    completion()
//                    return
//                }
//            } else {
//                print("خطأ في تحويل الصورة إلى PixelBuffer")
//                completion()
//                return
//            }
//        }
//        completion()
//    }
//    
//    // تحويل صورة إلى PixelBuffer
//    func pixelBuffer(from image: UIImage) -> CVPixelBuffer? {
//        let size = image.size
//        var pixelBuffer: CVPixelBuffer? = nil
//        
//        let attrs: [String: Any] = [
//            kCVPixelBufferCGImageCompatibilityKey as String: true,
//            kCVPixelBufferCGBitmapContextCompatibilityKey as String: true
//        ]
//        
//        let status = CVPixelBufferCreate(kCFAllocatorDefault,
//                                          Int(size.width),
//                                          Int(size.height),
//                                          kCVPixelFormatType_32BGRA,
//                                          attrs as CFDictionary,
//                                          &pixelBuffer)
//        
//        if status != kCVReturnSuccess {
//            print("خطأ في إنشاء pixelBuffer")
//            return nil
//        }
//        
//        guard let buffer = pixelBuffer else {
//            print("خطأ في تحويل الصورة إلى buffer")
//            return nil
//        }
//        
//        let context = CGContext(
//            data: CVPixelBufferGetBaseAddress(buffer),
//            width: Int(size.width),
//            height: Int(size.height),
//            bitsPerComponent: 8,
//            bytesPerRow: CVPixelBufferGetBytesPerRow(buffer),
//            space: CGColorSpaceCreateDeviceRGB(),
//            bitmapInfo: CGBitmapInfo.byteOrder32Little.rawValue | CGImageAlphaInfo.premultipliedFirst.rawValue)
//        
//        context?.draw(image.cgImage!, in: CGRect(origin: .zero, size: size))
//        
//        return buffer
//    }
//}
