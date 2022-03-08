# MIT License
# Copyright (c) 2020 Dominik Picheta

# Copyright 2020 Zeshen Xing
# 
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
# 
# http://www.apache.org/licenses/LICENSE-2.0
# 
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.


import options, httpcore, parseutils


func parseHttpMethod*(data: string, start: int): Option[HttpMethod] =
        ## Parses the data to find the request HttpMethod.

        # HTTP methods are case sensitive.
        # (RFC7230 3.1.1. "The request method is case-sensitive.")
        case data[start]
        of 'G':
                if data[start+1] == 'E' and data[start+2] == 'T':
                        result = some(HttpGet)
        of 'H':
                if data[start+1] == 'E' and data[start+2] == 'A' and data[start+3] == 'D':
                        result = some(HttpHead)
        of 'P':
                if data[start+1] == 'O' and data[start+2] == 'S' and data[start+3] == 'T':
                        result = some(HttpPost)
                if data[start+1] == 'U' and data[start+2] == 'T':
                        result = some(HttpPut)
                if data[start+1] == 'A' and data[start+2] == 'T' and
                         data[start+3] == 'C' and data[start+4] == 'H':
                        result = some(HttpPatch)
        of 'D':
                if data[start+1] == 'E' and data[start+2] == 'L' and
                         data[start+3] == 'E' and data[start+4] == 'T' and
                         data[start+5] == 'E':
                        result = some(HttpDelete)
        of 'O':
                if data[start+1] == 'P' and data[start+2] == 'T' and
                         data[start+3] == 'I' and data[start+4] == 'O' and
                         data[start+5] == 'N' and data[start+6] == 'S':
                        result = some(HttpOptions)
        else:
                result = none(HttpMethod)

func parsePath*(data: string, start: int): Option[string] =
        ## Parses the request path from the specified data.
        if unlikely(data.len == 0):
                return

        # Find the first ' '.
        # We can actually start ahead a little here. Since we know
        # the shortest HTTP method: 'GET'/'PUT'.
        var i = start + 2
        while data[i] notin {' ', '\0'}:
                inc i

        if likely(data[i] == ' '):
                # Find the second ' '.
                inc i # Skip first ' '.
                let start = i
                while data[i] notin {' ', '\0'}:
                        inc i

                if likely(data[i] == ' '):
                        return some(data[start..<i])
        else:
                return none(string)

func parseHeaders*(data: string, start: int): Option[HttpHeaders] =
        if unlikely(data.len == 0):
                return

        var pairs: seq[(string, string)] = @[]

        var i = start
        # Skip first line containing the method, path and HTTP version.
        while data[i] != '\l':
                inc i

        inc i # Skip \l

        var value = false
        var current: (string, string) = ("", "")
        while i < data.len:
                case data[i]
                of ':':
                        if value: 
                                current[1].add(':')
                        value = true
                of ' ':
                        if value:
                                if current[1].len != 0:
                                        current[1].add(data[i])
                        else:
                                current[0].add(data[i])
                of '\c':
                        discard
                of '\l':
                        if current[0].len == 0:
                                # End of headers.
                                return some(newHttpHeaders(pairs))

                        pairs.add(current)
                        value = false
                        current = ("", "")
                else:
                        if value:
                                current[1].add(data[i])
                        else:
                                current[0].add(data[i])
                inc i

        return none(HttpHeaders)

func parseContentLength*(data: string, start: int): int =
        result = 0

        let headers = data.parseHeaders(start)
        if headers.isNone:
                return

        if unlikely(not headers.get.hasKey("Content-Length")):
                return

        discard headers.get["Content-Length"].parseSaturatedNatural(result)

iterator parseRequests*(data: string): int =
        ## Yields the start position of each request in `data`.
        ##
        ## This is only necessary for support of HTTP pipelining. The assumption
        ## is that there is a request at position `0`, and that there MAY be another
        ## request further in the data buffer.
        var i = 0
        yield i

        while i + 3 < len(data):
                if data[i+0] == '\c' and data[i+1] == '\l' and
                         data[i+2] == '\c' and data[i+3] == '\l':
                        if likely(i + 4 == len(data)): 
                                break
                        i.inc(4)
                        if parseHttpMethod(data, i).isNone:
                                continue
                        yield i

                inc i
