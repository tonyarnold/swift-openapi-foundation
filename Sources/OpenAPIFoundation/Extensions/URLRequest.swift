//===----------------------------------------------------------------------===//
//
// This source file originally came from the SwiftOpenAPIGenerator open
// source project: https://github.com/apple/swift-openapi-urlsession
//
// Copyright (c) 2023 Apple Inc. and the SwiftOpenAPIGenerator project authors
// Licensed under Apache License v2.0
//
// See LICENSE.txt for license information
// See CONTRIBUTORS.txt for the list of SwiftOpenAPIGenerator project authors
//
// SPDX-License-Identifier: Apache-2.0
//
//===----------------------------------------------------------------------===//

import Foundation
#if canImport(FoundationNetworking)
import FoundationNetworking
#endif
import HTTPTypes

extension URLRequest {
    init(_ request: HTTPRequest, baseURL: URL) throws {
        guard
            var baseURLComponents = URLComponents(string: baseURL.absoluteString),
            let requestURLComponents = URLComponents(string: request.path ?? "")
        else {
            throw FoundationClientTransportError.invalidRequestURL(
                path: request.path ?? "<nil>",
                method: request.method,
                baseURL: baseURL
            )
        }

        let path = requestURLComponents.percentEncodedPath
        baseURLComponents.percentEncodedPath += path
        baseURLComponents.percentEncodedQuery = requestURLComponents.percentEncodedQuery

        guard let url = baseURLComponents.url else {
            throw FoundationClientTransportError.invalidRequestURL(
                path: path,
                method: request.method,
                baseURL: baseURL
            )
        }

        self.init(url: url)
        self.httpMethod = request.method.rawValue

        for header in request.headerFields {
            self.setValue(header.value, forHTTPHeaderField: header.name.canonicalName)
        }
    }
}
