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
        recognitionRequest.
    }
}
