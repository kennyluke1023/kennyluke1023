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
docker build -t openclaw:local -f Dockerfile .
docker compose run --rm openclaw-cli onboard
docker compose up -d openclaw-gateway
```
這兩種方式都可以安裝，第二種方式則可以在Docker-compose 檔案先修改；第一種要自己再找出檔案再修改。
