# GitHub 上手：从零到每天一键提交

> 一次性配置约 40 分钟。做完之后，每天只需要双击 `daily-push.bat`。

---

## 阶段一：一次性配置（只做一次）

### 1. 注册 GitHub 账号
打开 https://github.com/signup ，用常用邮箱注册。
**用户名建议**：用真名拼音或稳定昵称，不要用随机串——这个 ID 以后会写进简历。

### 2. 配置 Git 身份（必做，否则无法提交）
打开 Git Bash 或 PowerShell，执行：

```bash
git config --global user.name "你的GitHub用户名"
git config --global user.email "你的GitHub邮箱"
git config --global init.defaultBranch main
git config --global core.autocrlf true
```

> 你目前**还没配置这两项**，所以现在直接 commit 会报错。这是新手最常见的第一个坑。

### 3. 在 GitHub 上建一个空仓库
- 右上角 `+` → `New repository`
- Repository name 填：`fde-journey`
- **选 Public**（公开仓库才能当作品集用；如果你担心数据，见下方「安全提醒」）
- **不要**勾选 Add README / .gitignore / license（本地已经有了，勾了会冲突）
- 点 Create repository

建好后页面会显示一个地址，形如：
`https://github.com/你的用户名/fde-journey.git`

### 4. 关联本地仓库并首次推送

在 `fde-journey` 目录下执行（把用户名换成你的）：

```bash
git remote add origin https://github.com/你的用户名/fde-journey.git
git branch -M main
git commit -m "D0: 初始化仓库，建立目录结构与提交流程"
git push -u origin main
```

第一次 push 会弹窗让你登录 GitHub，用浏览器授权即可。之后一段时间内不再问。

### 5. 验证成功
刷新 GitHub 页面，能看到 README.md 和那些文件夹 → 成功。

---

## 阶段二：每天的日常（3 条命令，或双击 bat）

### 方式 A：命令行
```bash
git add .
git commit -m "D1: 完成养护流程审计表 v0"
git push
```

### 方式 B：双击 `daily-push.bat`
会先列出改动了哪些文件，让你输入一句话说明，然后自动 add → commit → push。
**推荐用这个**，不容易忘、也不会漏步骤。

---

## Commit message 怎么填

统一格式：`D<第几天>: <做了什么>`

```
好例子：
  D1: 完成养护流程审计表 v0，圈定主攻流程为巡查记录整理
  D10: 建 20 条黄金数据集第一轮人工标注
  D45: RAG 接入养护规范，20 问对 15

坏例子：
  update
  修改
  .
```

90 天后这条提交历史就是你的学习曲线。写得越具体，将来越好讲。

---

## 什么时候提交

推荐节奏：**每次学习结束就提交一次**，不用攒。
理由不是"养成习惯"这种空话——而是 commit 的粒度越细，将来你要回溯"某次改动到底让效果变好还是变坏"时，越容易定位。这本身就是 W10 做 eval 时的思维方式。

---

## 安全提醒（重要）

1. **真实业务数据脱敏后再提交**。桩号、地名、人名能改就改；`.gitignore` 已经屏蔽了 `*.xlsx / *.csv / *.db`，但如果你要提交示例数据，请先手动脱敏成 `sample_` 前缀的假数据。
2. **绝不要提交密钥**。API Key、Token 一律放 `.env`，`.gitignore` 已屏蔽。真不小心提交了，立刻去平台作废重签——GitHub 上有爬虫专门扫这个。
3. 如果单位对数据外发有规定，**改用 Private 仓库**，或者只提交方法论文档、不提交数据。

---

## 常见问题

**Q：push 提示权限错误 / 登录失败？**
```bash
git credential-manager github login
```
或在浏览器登录 GitHub 后重试。2021 年后 GitHub 不再接受账号密码，必须用 token 或浏览器授权。

**Q：`git commit` 报 "Please tell me who you are"？**
说明第 2 步的身份配置没做。补上即可。

**Q：中文文件名显示成一串数字？**
```bash
git config --global core.quotepath false
```

**Q：提交错东西了怎么办？**
还没 push：`git reset --soft HEAD~1` 撤销上次 commit，文件保留。
已经 push：别慌，删掉文件再提交一次即可（历史里那条删不掉，但内容能撤；**密钥除外，密钥必须立刻作废**）。

**Q：我想把仓库挪到别的地方？**
整个 `fde-journey` 文件夹（含隐藏的 `.git`）一起拷贝/移动就行，仓库历史跟着走。

---

## 更进一步（W3 之后再碰）

W3 会学到分支。到那时再了解：`git branch` / `git checkout -b` / PR。
**现在不要学分支**——你一个人干活，主线提交足够了，提前学分支只会增加认知负担。
