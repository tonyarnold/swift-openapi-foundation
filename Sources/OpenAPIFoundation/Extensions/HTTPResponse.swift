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

extension HTTPResponse {
    init(_ urlResponse: URLResponse) throws {
        guard let httpResponse = urlResponse as? HTTPURLResponse else {
            throw FoundationClientTransportError.notHTTPResponse(urlResponse)
        }

        var headerFields = HTTPFields()

        for (headerName, headerValue) in httpResponse.allHeaderFields {
            guard let rawName = headerName as? String, let name = HTTPField.Name(rawName),
                  let value = headerValue as? String
            else {
                continue
            }
            headerFields[name] = value
        }

        self.init(status: .init(code: httpResponse.statusCode), headerFields: headerFields)
    }
}
