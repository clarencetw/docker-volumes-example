# Docker volumes example
測試是否掛載 docker volumes 與 entrypoint 下載檔案制本地目錄

## Folder
1. data 資料夾用於創建下載檔案的 docker
2. http-server 資料夾用於創建 http server docker

## Docker build
`docker build -t data ./data`
`docker build -t http-server ./http-server`

## 使用無掛載 volumes 方法執行
1. `docker run --name data data`
2. `docker run --rm --volumes-from data --name http-server -p 8080:8080 http-server /data`
3. 使用 `curl -v http://localhost:8080/ -o /dev/null` 測試有檔案
```
  % Total    % Received % Xferd  Average Speed   Time    Time     Time  Current
                                 Dload  Upload   Total   Spent    Left  Speed
  0     0    0     0    0     0      0      0 --:--:-- --:--:-- --:--:--     0*   Trying ::1...
* TCP_NODELAY set
* Connected to localhost (::1) port 8080 (#0)
> GET / HTTP/1.1
> Host: localhost:8080
> User-Agent: curl/7.64.1
> Accept: */*
>
< HTTP/1.1 200 OK
< accept-ranges: bytes
< cache-control: max-age=3600
< last-modified: Mon, 09 Aug 2021 14:15:45 GMT
< etag: W/"3705048-33-2021-08-09T14:15:45.052Z"
< content-length: 33
< content-type: text/html; charset=UTF-8
< Date: Mon, 09 Aug 2021 15:18:13 GMT
< Connection: keep-alive
< Keep-Alive: timeout=5
<
{ [33 bytes data]
100    33  100    33    0     0    578      0 --:--:-- --:--:-- --:--:--   578
* Connection #0 to host localhost left intact
* Closing connection 0
```
4. 使用 `curl -v http://localhost:8080/html/ -o /dev/null` 測試有檔案
```
  % Total    % Received % Xferd  Average Speed   Time    Time     Time  Current
                                 Dload  Upload   Total   Spent    Left  Speed
  0     0    0     0    0     0      0      0 --:--:-- --:--:-- --:--:--     0*   Trying ::1...
* TCP_NODELAY set
* Connected to localhost (::1) port 8080 (#0)
> GET /html/ HTTP/1.1
> Host: localhost:8080
> User-Agent: curl/7.64.1
> Accept: */*
>
< HTTP/1.1 200 OK
< accept-ranges: bytes
< cache-control: max-age=3600
< last-modified: Mon, 09 Aug 2021 15:17:57 GMT
< etag: W/"3705052-137453-2021-08-09T15:17:57.448Z"
< content-length: 137453
< content-type: text/html; charset=UTF-8
< Date: Mon, 09 Aug 2021 15:19:01 GMT
< Connection: keep-alive
< Keep-Alive: timeout=5
<
{ [32453 bytes data]
100  134k  100  134k    0     0  5162k      0 --:--:-- --:--:-- --:--:-- 5162k
* Connection #0 to host localhost left intact
* Closing connection 0
```

## 使用掛載 volumes 方法執行
1. `docker run --name data -v /Users/user/data:/data data`
2. 本機 /Users/user/data/html 出現下載檔
3. `docker run --rm --volumes-from data --name http-server -p 8080:8080 http-server /data`
4. 使用 `curl -v http://localhost:8080/ -o /dev/null` 測試無檔案
```
  % Total    % Received % Xferd  Average Speed   Time    Time     Time  Current
                                 Dload  Upload   Total   Spent    Left  Speed
  0     0    0     0    0     0      0      0 --:--:-- --:--:-- --:--:--     0*   Trying ::1...
* TCP_NODELAY set
* Connected to localhost (::1) port 8080 (#0)
> GET / HTTP/1.1
> Host: localhost:8080
> User-Agent: curl/7.64.1
> Accept: */*
>
< HTTP/1.1 403 Forbidden
< accept-ranges: bytes
< Date: Mon, 09 Aug 2021 15:16:14 GMT
< Connection: keep-alive
< Keep-Alive: timeout=5
< Content-Length: 0
<
  0     0    0     0    0     0      0      0 --:--:-- --:--:-- --:--:--     0
* Connection #0 to host localhost left intact
* Closing connection 0
```
5. 使用 `curl -v http://localhost:8080/html/ -o /dev/null` 測試有檔案
```
  % Total    % Received % Xferd  Average Speed   Time    Time     Time  Current
                                 Dload  Upload   Total   Spent    Left  Speed
  0     0    0     0    0     0      0      0 --:--:-- --:--:-- --:--:--     0*   Trying ::1...
* TCP_NODELAY set
* Connected to localhost (::1) port 8080 (#0)
> GET /html/ HTTP/1.1
> Host: localhost:8080
> User-Agent: curl/7.64.1
> Accept: */*
>
< HTTP/1.1 200 OK
< accept-ranges: bytes
< cache-control: max-age=3600
< last-modified: Mon, 09 Aug 2021 15:01:56 GMT
< etag: W/"74491141-137453-2021-08-09T15:01:56.752Z"
< content-length: 137453
< content-type: text/html; charset=UTF-8
< Date: Mon, 09 Aug 2021 15:16:29 GMT
< Connection: keep-alive
< Keep-Alive: timeout=5
<
{ [14164 bytes data]
100  134k  100  134k    0     0  6391k      0 --:--:-- --:--:-- --:--:-- 6391k
* Connection #0 to host localhost left intact
* Closing connection 0
```