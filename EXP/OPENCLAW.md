# Docker + Openclaw  
以下內容是親身試驗**Docker + Openclaw**是極致的麻煩，但我最後不知道發生了什麼事則成功了，所以必須地記錄下來。  

## 前言
Openclaw 最大的痛點權限，畢竟人類把所有的權限都交給AI(LLM，我假設大家都知道LLM的本質...)而AI最大的問題是他是黑盒子(blackbox)。指它們的思考(演算法)是不透明，而不能預測的，換言之便是把家中鎖匙的權力交由一個完全不認識的人(差不多意會意會)。OpenClaw兩個的隱憂，內部是不能預測它的行為，可能會在電腦上大刀寛斧，直接把所有東西刪去(rm -rf *)；外部則是網域的設置，及使用其他工具，這些都會輕易被人駭入，或植入惡意的程式，再加上權限全交由電腦，事件已經發展到人能預測的地步。所以，我個人會追求安全的設置，用上Docker容器的工具，能多一層保護(相對而言)。以下則把所有的踩過的坑，記錄一下，因為我也不知道我如何成功?!?(me: 反正我就是行了 HEHE)重新地記錄一下，日後回來再看看。

### STEP 1  
Docker 的安裝就不再多說了，直接由openclaw的github入手，建議先創立新的檔案(mkdir Agent/<YOUR_FOLDER>)把repo直接放入。  
```bash
mkdir OPENCLAW
cd OPENCLAW
git clone https://github.com/openclaw/openclaw.git
```
完成後，查看官方的文件<https://docs.openclaw.ai/install/docker>內容是Docker安裝的方式。文件提供了兩個安裝的方式：  
> 這是第一種方式
```bash

./scripts/docker/setup.sh
```

```bash
./docker-setup.sh
```
以上兩個指令都是做同一樣的事，用官方的文件直接下載。  
> 第二種方式 Docker compose
```bash
## update 25/3/2026
docker build -t openclaw:local -f Dockerfile .
docker compose run --rm --no-deps --entrypoint node openclaw-gateway \
  dist/index.js onboard --mode local --no-install-daemon
docker compose run --rm --no-deps --entrypoint node openclaw-gateway \
  dist/index.js config set gateway.mode local
docker compose run --rm --no-deps --entrypoint node openclaw-gateway \
  dist/index.js config set gateway.bind lan
docker compose run --rm --no-deps --entrypoint node openclaw-gateway \
  dist/index.js config set gateway.controlUi.allowedOrigins \
  '["http://localhost:18789","http://127.0.0.1:18789"]' --strict-json
docker compose up -d openclaw-gateway
```
```bash
## 下方沒有用的，但我要永做記錄...官方....我X你老...
#docker build -t openclaw:local -f Dockerfile .
#docker compose run --rm openclaw-cli onboard
#docker compose up -d openclaw-gateway
```
這兩種方式都可以安裝，第二種方式則可以在Docker-compose 檔案先修改；第一種要自己再找出檔案再修改。  
見到以下的圖片，可以進入openclaw設定：
openclaw的 setup.jpg (提醒個token...)
詳情不用多說，youtube 有一堆的教學(Search: Openclaw安裝則可以了，選擇quickly start)。要注意地方，在Docker 的設定中，最當遇到的問題是，Gateway連不上，所以照我的做法會選擇mamual，會在openclaw setup先設定Gateway用"lan"(官方應該也是這樣建議吧)，這是說明你用那個方式進入openclaw的應用介面。其後的部份則可以按youtube教學則可以。當你選擇好了，也不會一定是順利XD
直到以下的面畫出現，說明你的設定已經完成了，(補張jpg)

### SETP 2   
當完成了，先必開心...困難剛剛要來了，這肯定是環境部著，正。接下來可以再用這段command。這段的則會再叫多次url出來，預設是 **http://127.0.0.1:18789/** ：
```bash
docker compose run --rm openclaw-cli dashboard --no-open
```
多數人可能遇到的問題，是不能接連上http://127.0.0.1:18789/，其因為是沒有openclaw config 檔案中加入url，或沒有打開gateway，這時在Docker desktop 的container會找到報錯的信息(但你不是用docker desktop，你大概個高手，也是個狠人) >> ...報錯的信息  
接下來就是我寫文章的重點了，這個報錯是接openclaw 找不到你預設的http://127.0.0.1:18789/地址，所以你輸入地址也沒有反應。我們要做的是先把Docker關掉  
```bash
docker compose down
```
只要見到remove則說明成功。我們要好檢查，到底為什麼找不到，通常是有config的設定有誤。所以我們要找一個 **.openclaw.json** 。  
**macOS**
直接使用快捷鍵搜尋：
* 按下 **`Command` + `Space`**
* 輸入：`.openclaw.json`

---
***🐧Linux / WSL ***
使用 `find` 指令進行搜尋：

```bash
find . -name "*.openclaw.json"
