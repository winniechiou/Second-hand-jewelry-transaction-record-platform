node.js (Ethereum TestRPC ) & Web3.js 參考資源
https://www.youtube.com/watch?v=hcTPjpPvas8

*其中 install Ethereumjs-testrpc 這一步打下面這句才會成功(for Windows, Mac 我不確定)
npm install ethereumjs-testrpc web3@0.20.1

============================================
Files (放工作目錄裡面):
-Contract
JewelryTransaction.sol

-Demo
index.html
main.css
=============================================

操作流程
Step1.
先從Remix上compile contract，複製 Interface-ABI & ByteCode 貼到index.html中(標示處)

Step2. 
Run > ganache-cli

Step3.
Run index.html in the browser.

-選一個account然後按下 Deploy (不用開Remix來Deploy)

-輸入紀錄:
正確填好資料按下 "Add new record"

-查詢資料:
輸入ID，按下 "Retrieve"

*目前沒有作錯誤處理，若上面輸入錯誤會重整頁面，重新 Deploy 再繼續!!!