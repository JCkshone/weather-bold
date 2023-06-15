//
//  Store.swift
//  Weather
//
//  Created by Juan camilo Navarro on 13/06/23.
//

import Combine
import Foundation
import Resolver

public typealias Reducer<State, Action> = (inout State, Action) -> Void
public typealias Middleware<State, Action> = (State, Action) -> AnyPublisher<Action, Never>?

@propertyWrapper
public class TruthState<Value> {
    private var currentValue: Value
    private let publisher: CurrentValueSubject<Value, Never>

    public init(wrappedValue: Value) {
        currentValue = wrappedValue
        publisher = CurrentValueSubject(wrappedValue)
    }

    public var wrappedValue: Value {
        get { currentValue }
        set {
            currentValue = newValue
            publisher.send(newValue)
        }
    }

    public var projectedValue: AnyPublisher<Value, Never> {
        publisher.eraseToAnyPublisher()
    }
}

public final class Store<State, Action>: ObservableObject {
    @TruthState public private(set) var state: State

    private let reducer: Reducer<State, Action>
    private let middlewares: [Middleware<State, Action>]
    private var cancellables = Set<AnyCancellable>()

    public init(state: State, reducer: @escaping Reducer<State, Action>, middlewares: [Middleware<State, Action>] = []) {
        self.state = state
        self.reducer = reducer
        self.middlewares = middlewares
    }

    public func dispatch(_ action: Action) {
        debugPrint("[Store \(String(describing: State.self))] dispatch Action: \(action)")
        reducer(&state, action)

        for middleware in middlewares {
            guard let effect = middleware(state, action) else { break }
            effect
                .receive(on: DispatchQueue.main)
                .sink(receiveValue: dispatch)
                .store(in: &cancellables)
        }
    }
}
