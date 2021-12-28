//
//  HXHVoiceVC.swift
//  HXHSwiftHub
//
//  Created by huangyu on 2021/12/20.
//

import UIKit
import Speech
import YYKit


class HXHVoiceVC: HXHBaseViewController, SFSpeechRecognizerDelegate, SFSpeechRecognitionTaskDelegate {
    
    private var gifImgView: YYAnimatedImageView?
    @IBOutlet weak var statusLabel: UILabel!
    @IBOutlet weak var pressBtn: UIButton!
    private let speechRecognizer = SFSpeechRecognizer(locale: Locale.current)
    
    private var recognitionRequest: SFSpeechAudioBufferRecognitionRequest?
    private var recognitionTask: SFSpeechRecognitionTask?
    private let audioEngine = AVAudioEngine()
    
    //MARK: - life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupSpeechRecognizer()
    }
    //MARK: - setupUI {
    private func setupUI() {
        
        let img2 = YYImage(named: "voice_speech.gif")
        gifImgView = YYAnimatedImageView(image: img2)
        guard let gifImgView = gifImgView else {
            return
        }
        
        view.addSubview(gifImgView)
        gifImgView.snp.makeConstraints { make in
            make.top.equalTo(self.view.snp.top).offset(self.view.safeAreaInsets.top)
            make.left.equalTo(self.view.snp.left).offset(self.view.safeAreaInsets.left)
            make.right.equalTo(self.view.snp.right).offset(self.view.safeAreaInsets.right)
            make.height.equalTo(200)
        }
        gifImgView.isHidden = true
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
    //MARK: - action
    
    @IBAction func openAction(_ sender: UIButton) {
        let str = "1234://message_QA?senderName=sss"
        guard let url = URL(string: str) else {
            print("url failure")
            return
        }
        UIApplication.shared.open(url) { isSuccess in
            print(isSuccess)
        }
    }
    
    @IBAction func pressAction(_ sender: UIButton) {
        if audioEngine.isRunning {
            audioEngine.stop()
            self.audioEngine.inputNode.removeTap(onBus: 0)
            
            recognitionRequest?.endAudio()
            
            pressBtn.setTitle("Start Recording", for: .normal)
            gifImgView?.isHidden = true
        } else {
            startSpeech()
            pressBtn.setTitle("stop recording", for: .normal)
            gifImgView?.isHidden = false
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
        
        recognitionTask = speechRecognizer?.recognitionTask(with: recognitionRequest, delegate: self)
        //        recognitionTask = speechRecognizer?.recognitionTask(with: recognitionRequest, resultHandler: { result, error in
        //            var isFinal = false
        //            if result != nil {
        //                print("\(result?.bestTranscription.formattedString)")
        //                isFinal = result?.isFinal ?? false
        //                print("error : \(error?.localizedDescription)\nisFinal: \(result?.isFinal)")
        //            }
        //            if error != nil || isFinal {
        //                self.audioEngine.stop()
        //                self.audioEngine.inputNode.removeTap(onBus: 0)
        //                self.recognitionRequest = nil
        //                self.recognitionTask = nil
        //
        //            }
        //        })
        
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
    
    //MARK: - delegate
    
    func speechRecognizer(_ speechRecognizer: SFSpeechRecognizer, availabilityDidChange available: Bool) {
        if available {
            pressBtn.isEnabled = true
        } else {
            pressBtn.isEnabled = false
        }
    }
    
    
    // Called when the task first detects speech in the source audio
    func speechRecognitionDidDetectSpeech(_ task: SFSpeechRecognitionTask) {
        print("\(#function)")
    }
    // Called for all recognitions, including non-final hypothesis
    func speechRecognitionTask(_ task: SFSpeechRecognitionTask, didHypothesizeTranscription transcription: SFTranscription) {
        print("\(#function)")
        print("\(transcription.formattedString)")
    }
    
    
    // Called only for final recognitions of utterances. No more about the utterance will be reported
    func speechRecognitionTask(_ task: SFSpeechRecognitionTask, didFinishRecognition recognitionResult: SFSpeechRecognitionResult) {
        print("\(#function)")
        var isFinal = false
        
        print("\(recognitionResult.bestTranscription.formattedString)")
        isFinal = recognitionResult.isFinal
        print("isFinal: \(recognitionResult.isFinal)")
        
        if isFinal {
            self.audioEngine.stop()
            self.audioEngine.inputNode.removeTap(onBus: 0)
            self.recognitionRequest = nil
            self.recognitionTask = nil
            
        }
    }
    
    
    // Called when the task is no longer accepting new audio but may be finishing final processing
    func speechRecognitionTaskFinishedReadingAudio(_ task: SFSpeechRecognitionTask) {
        print("\(#function)")
    }
    
    
    // Called when the task has been cancelled, either by client app, the user, or the system
    func speechRecognitionTaskWasCancelled(_ task: SFSpeechRecognitionTask) {
        print("\(#function)")
    }
    
    
    // Called when recognition of all requested utterances is finished.
    // If successfully is false, the error property of the task will contain error information
    func speechRecognitionTask(_ task: SFSpeechRecognitionTask, didFinishSuccessfully successfully: Bool) {
        print("\(#function)")
    }
}
