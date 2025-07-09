//
//  AudioPlayerService.swift
//  Vocabulary
//
//  Created by Ziad Khalil on 09/07/2025.
//


import AVFoundation

class AudioPlayerService {
    private var synthesizer = AVSpeechSynthesizer()
    private var audioPlayer: AVAudioPlayer?
    
    init() {
        setupAudio()
    }
    
    private func setupAudio() {
        do {
            try AVAudioSession.sharedInstance().setCategory(.playback, mode: .default)
            try AVAudioSession.sharedInstance().setActive(true)
        } catch {
            print("Failed to setup audio session: \(error)")
        }
    }
    
    func playPronunciation(for word: String) {
        let utterance = AVSpeechUtterance(string: word)
        utterance.voice = AVSpeechSynthesisVoice(language: "en-US")
        utterance.rate = 0.4
        
        synthesizer.speak(utterance)
    }
    
    func playSuccessSound() {
        AudioServicesPlaySystemSound(1016)
        
    }
}
