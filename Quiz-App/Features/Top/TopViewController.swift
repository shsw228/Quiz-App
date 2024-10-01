//
//  ViewController.swift
//
//
//  Created by shsw228 on 2024/10/01
//

import Combine
import SwiftUI
import UIKit

class TopViewController: UIHostingController<TopView> {
    private var cancellables: Set<AnyCancellable> = []
    private let vm: TopViewModel

    init(vm: TopViewModel = TopViewModel()) {
        self.vm = vm
        super.init(rootView: TopView(vm: vm))
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "Top"

        vm.tapChallenge
            .receive(on: RunLoop.main)
            .print()
            .sink { _ in
                // TODO: 遷移処理
            }
            .store(in: &cancellables)
        vm.tapHistory
            .receive(on: RunLoop.main)
            .sink { _ in
                // TODO: 遷移処理
            }
            .store(in: &cancellables)
    }

}
class TopViewModel: ObservableObject {
    let tapChallenge = PassthroughSubject<Void, Never>()
    let tapHistory = PassthroughSubject<Void, Never>()
}

struct TopView: View {
    @State var isTapped = false
    @ObservedObject var vm = TopViewModel()
    var body: some View {
        VStack(spacing: 50) {
            Text("Quiz App")
                .font(.title)
            Spacer()
            Image(systemName: "graduationcap")
                .resizable()
                .padding()
                .symbolVariant(.circle)
                .symbolEffect(.bounce,options: .nonRepeating)
                .aspectRatio(contentMode: .fit)
            VStack(alignment: .center){
                Button(action: {
                    vm.tapChallenge.send()
                    isTapped.toggle()
                }) {
                    Label("Challenge Quiz", systemImage: "play")
                        .padding()
                }
                .buttonStyle(.borderedProminent)

                Button(action: {
                    vm.tapHistory.send()
                    isTapped.toggle()
                }) {
                    Label("History", systemImage: "clock")
                        .padding()
                }
                .buttonStyle(.bordered)
            }




        }
        .padding()
        .sensoryFeedback(.success, trigger:isTapped)
    }
}
#Preview {
    TopView()
}
