//
//  HXHVoiceVC.swift
//  HXHSwiftHub
//
//  Created by huangyu on 2021/12/20.
//

import UIKit
import Speech

class HXHVoiceVC: HXHBaseViewController, SFSpeechRecognizerDelegate {
    
    @IBOutlet weak var statusLabel: UILabel!
    @IBOutlet weak var pressBtn: UIButton!
    private let speechRecognizer = SFSpeechRecognizer(locale: Locale.current)
    
    private var recognitionRequest: SFSpeechAudioBufferRecognitionRequest?
    private var recognitionTask: SFSpeechRecognitionTask?
    private let audioEngine = AVAudioEngine()
    
    //MARK: - life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupSpeechRecognizer()
    }

    //MARK: - config
    private func setupSpeechRecognizer() {
        
        speechRecognizer?.delegate = self
        
        SFSpeechRecognizer.requestAuthorization { authStatus in
            
            OperationQueue.main.addOperation { [ weak self] in
                guard let self = self else { return }
                print(authStatus.rawValue)
                self.statusLabel.text = "auth status : \(authStatus.rawValue)"
                switch authStatus {
                case .notDetermined:
                    self.pressBtn.isEnabled = false
                case .denied:
                    self.pressBtn.isEnabled = false
                case .restricted:
                    self.pressBtn.isEnabled = false
                case .authorized:
                    self.pressBtn.isEnabled = true
                default:
                    print("unknown error")
                }
            }
            
        }
    }
    
    @IBAction func pressAction(_ sender: UIButton) {
        if audioEngine.isRunning {
            audioEngine.stop()
            recognitionRequest?.endAudio()
            pressBtn.setTitle("Start Recording", for: .normal)

        } else {
            startSpeech()
            pressBtn.setTitle("stop recording", for: .normal)
        }
    }
    func startSpeech() {
        if recognitionTask != nil {
            recognitionTask?.cancel()
            recognitionTask = nil
        }
        let audioSession = AVAudioSession.sharedInstance()
        do {
            try audioSession.setCategory(AVAudioSession.Category.record)
            try audioSession.setMode(.measurement)
            try audioSession.setActive(true, options: AVAudioSession.SetActiveOptions.notifyOthersOnDeactivation)
        } catch {
            print(error.localizedDescription)
        }
        recognitionRequest = SFSpeechAudioBufferRecognitionRequest()
        
//        guard let inputMode = audioEngine.inputNode else {
//            print("Audio engine has no input node")
//            return
//        }
        print("\(audioEngine.inputNode)")
        guard let recognitionRequest = recognitionRequest else {
            print("Unable to create an SFSpeechAudioBufferRecognitionRequest object")
            return
        }
        recognitionRequest.shouldReportPartialResults = true
        recognitionTask = speechRecognizer?.recognitionTask(with: recognitionRequest, resultHandler: { result, error in
            var isFinal = false
            if result != nil {
                print("\(result?.bestTranscription.formattedString)")
                isFinal = result?.isFinal ?? false
            }
            if error != nil || isFinal {
                self.audioEngine.stop()
                self.audioEngine.inputNode.removeTap(onBus: 0)
                self.recognitionRequest = nil
                self.recognitionTask = nil
                
            }
        })
        let recordingFormat = audioEngine.inputNode.outputFormat(forBus: 0)
        audioEngine.inputNode.installTap(onBus: 0, bufferSize: 1024, format: recordingFormat) { buffer, when in
            self.recognitionRequest?.append(buffer)
        }
        audioEngine.prepare()
        
        do {
            try audioEngine.start()
        } catch {
            print("audioEngine couldn't start because of an error. \(error.localizedDescription)")
        }
        print("Say something, I'm listening!")
    }
    
    func speechRecognizer(_ speechRecognizer: SFSpeechRecognizer, availabilityDidChange available: Bool) {
        if available {
            pressBtn.isEnabled = true
        } else {
            pressBtn.isEnabled = false
        }
    }
    
}
