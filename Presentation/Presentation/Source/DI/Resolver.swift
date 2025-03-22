//
//  Resolver.swift
//  Presentation
//
//  Created by Вадим Мартыненко on 22.03.2025.


public protocol Resolver: AnyObject {
    func resolve<Service>(_ serviceType: Service.Type) -> Service?
    
    func resolve<Service, Arg1>(
        _ serviceType: Service.Type,
        argument: Arg1
    ) -> Service?
}
