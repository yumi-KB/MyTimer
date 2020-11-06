//
//  ViewController.swift
//  MyTimer
//
//  Created by yumi kanebayashi on 2020/11/04.
//

import UIKit

class ViewController: UIViewController {
    // タイマーの変数を作成
    var timer: Timer?
    
    // カウント（経過時間）の変数を作成
    var count = 0
    
    // 設定値を扱うキーを設定
    let settingKey = "timer_value"

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // UserDefaultsのインスタンスを作成
        let settings = UserDefaults.standard
        
        // UserDefaultsに初期値を登録 辞書型
        settings.register(defaults: [settingKey : 10])
    }
    
    override func viewDidAppear(_ animated: Bool) {
        count = 0
        
        // タイマーの表示を更新する
        _ = displayUpdate()
    }
    
    @IBAction func setingButtonAction(_ sender: Any) {
        if let nowTimer = timer {
            stopTimer(nowTimer)
//            // もしタイマーが、実行中だったら停止
//            if nowTimer.isValid == true {
//                // タイマーを停止
//                nowTimer.invalidate()
//            }
        }
        
        // 画面遷移を行う
        performSegue(withIdentifier: "goSetting", sender: nil)
    }
    
    @IBOutlet weak var countDownLabel: UILabel!
    
    @IBAction func startButtonAction(_ sender: Any) {
        if let nowTimer = timer {
            // もしタイマーが、実行中だったらスタートしない
            if nowTimer.isValid == true {
                // 何も処理しない
                return
            }
        }
        // タイマーをスタート
        timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(self.timerInterrupt(_:)), userInfo: nil, repeats: true)
    }
    
    
    @IBAction func stopButtonAction(_ sender: Any) {
        if let nowTimer = timer {
            // もしタイマーが、実行中だったら停止
            if nowTimer.isValid == true {
                // タイマーを停止
                nowTimer.invalidate()
            }
        }
    }
    
    
    // 画面の更新をする
    func displayUpdate() -> Int {
        // UserDefaultsのインスタンスを生成
        let settings = UserDefaults.standard
        
        // 取得した秒数をtimeValueに渡す
        let timeValue = settings.integer(forKey: settingKey)
        
        // 残り時間(remainCount)を生成
        let remainCount = timeValue - count
        
        // remainCountをラベルに表示
        countDownLabel.text = "残り\(remainCount)秒"
        
        return remainCount
    }
    
    @objc func timerInterrupt(_ timer: Timer) {
        // 経過時間の増加をカウント
        count += 1
        
        // remainCount(残り時間)が 0以下の時、タイマーを止める
        if displayUpdate() <= 0 {
            // 初期化処理
            count = 0
            
            // タイマー停止
            timer.invalidate()
        }
    }
    
    func stopTimer(_ nowTimer: Timer) {
        // もしタイマーが、実行中だったら停止
        if nowTimer.isValid == true {
            // タイマーを停止
            nowTimer.invalidate()
        }
    }
}

