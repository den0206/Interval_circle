//
//  SettingsView.swift
//  Interval_circle
//
//  Created by 酒井ゆうき on 2020/10/28.
//

import SwiftUI

struct SettingsView: View {
    
    enum settingSheetView : Identifiable {
        case set
        
        var id : Int {
            hashValue
        }
    }
    
    @EnvironmentObject var model : IntervalModel
    
    @AppStorage(AppStorageKey.timer) var timerStorage = 0
    @AppStorage(AppStorageKey.interval) var intervalStorage  = 0
    @AppStorage(AppStorageKey.set) var setStorage  = 1
    
    @AppStorage(AppStorageKey.showMovie) var showMovie = true
   
    @State var timerAngle : Double = 0
    @State var intervalAngle : Double = 0
    @State var sheetView : settingSheetView?
    
    @State private var showHUD = false
    @State private var showAlert = false
    @State private var alert = Alert(title: Text(""))
    

    
    var body: some View {
        
        ZStack {
            
            
            /// Z1
            VStack(alignment: .trailing) {
                
                HStack() {
                    
                    Spacer()
                    
                    VStack {
                        Toggle("", isOn: $showMovie)
                            .labelsHidden()
                        Text(showMovie ? "No Movie" : "動画表示")
                            .font(.caption2)
                            .foregroundColor(.white)
                    }
                }
                .padding()
              
                Spacer()
            }
            .padding(.top, 13)
            
            /// Z2
            VStack() {
                
              Spacer()
                
                Group {
                    
                    Text("稼働時間")
                        .foregroundColor(.white)
                        .padding(.bottom, 5)

                   
                    
                    Circular_Slider(size: 130, circleColor: Color.green, maxValue: model.maxValue, progress: $model.selectedCount, angle: $timerAngle)
                   
                }
                .padding(10)
               
                Group {
                    Text("休憩時間")
                        .foregroundColor(.white)
                        .padding(.bottom, 5)
                    
                    Circular_Slider(size: 130, circleColor: Color.red, maxValue: model.maxValue, progress: $model.selectedInterval, angle: $intervalAngle)
                }
                
                .padding(10)
                
                Spacer()
                
                Button(action: {
                    sheetView = .set
                }) {
                    
                    Text("\(model.selectedSet) セット")
                        .foregroundColor(.white)
                        .padding(.vertical)
                        .padding(.horizontal,40)
                        .background(configureGradient(trailingColor: .purple))
                        .clipShape(Capsule())
                    
                }.padding(.top,10)
                
                Spacer()
                
                HStack {
                    
                    Button(action: {
                        
                        guard model.time > 5 && model.interval > 5  else {
                            
                            showAlert = true
                            alert = Alert(title: Text("タイマーが少し短いようです。"), message: Text("5秒以上にして頂けると助かります"), dismissButton: .default(Text("OK")))
                            
                            return
                        }
                        
                        saveStorage()
                    }) {
                        Text("Save")
                            .foregroundColor(.white)
                            .padding(.vertical)
                            .padding(.horizontal,40)
                            .background(configureGradient(trailingColor: .yellow))
                            .clipShape(Capsule())
                        
                    }
                    
                    Button(action: {
                        
                        guard model.time > 5 && model.interval > 5  else {
                            
                            showAlert = true
                            alert = Alert(title: Text("タイマーが少し短いようです。"), message: Text("5秒以上にして頂けると助かります"), dismissButton: .default(Text("OK")))
                            
                            return
                        }
                        
                        saveStorage()
                        model.state = .prepare
                    }) {
                        Text("スタート")
                            .foregroundColor(.white)
                            .padding(.vertical)
                            .padding(.horizontal,40)
                            .background(configureGradient(trailingColor: .green))
                            .clipShape(Capsule())
                        
                    }
                    
                    
                    
                }
                .padding(.bottom, 20)
            
            }
            .frame(width: UIScreen.main.bounds.width, height:  UIScreen.main.bounds.height)
            .sheet(item: $sheetView, content: { (item) in
                switch item {
                case .set :
                    SetListView { (i) in
                        model.selectedSet = i
                    }
                }
            })
            .showHUD(isShowing: $showHUD, Text("Saveに成功しました!"))
            .alert(isPresented: $showAlert, content: {
                alert
            })
            .onAppear {
                self.model.intervalTimer.upstream.connect().cancel()
                
                self.model.selectedCount = CGFloat(timerStorage) / model.maxValue
                self.model.selectedInterval =  CGFloat(intervalStorage) / model.maxValue
                self.model.selectedSet = setStorage
                
                self.timerAngle = Double(self.model.selectedCount * 360)
                self.intervalAngle = Double(self.model.selectedInterval * 360)
            }
            
        }
        .background(showMovie ? AnyView(LooperBackgroundView())  : AnyView(Color.black))
        .ignoresSafeArea(.all, edges: .top)
        
    }
    
   
}

extension SettingsView {
    
    
    private func saveStorage() {
        timerStorage = model.time
        intervalStorage = model.interval
        setStorage = model.selectedSet
        
        showHUD = true
        print(timerStorage, intervalStorage, setStorage)
    }
   
}

