# onzokai

## 使用方法

1. 你的视频文件，复制一份改名`2c.mp4`，和 `cut 2c.mp4 to c.mp4.rb` 放在同一个文件夹，打开。
2. 从`2c.mp4`中输出一帧画面 为 `2c.png`
3. 打开 `2c裁剪xywh.html` 选取裁剪范围，自动复制参数。
4. 回到`cut 2c.mp4 to c.mp4.rb`，输入缩放倍数。然后黏贴 刚刚复制的裁切参数。回车。
   - 等待完成。
5. 完成后多出一个`kfs` 的文件夹，使用去重软件或者 python 库 去重。也可以将关键帧复制到 `kfx` 文件夹。
6. 完成后，打开`根据关键帧图片（.jpeg）kfs文件夹的帧序导出 srt.rb`，输入所需参数。
   - 完成

















## 安装方法

主要用于视频的使用，语言是 ruby

需要安装 ffmpeg。并添加环境变量

按 <kbd>Win</kbd> + <kbd>R</kbd> -> 运行输入 `sysdm.cpl` <kbd>Enter</kbd> -> 高级 -> 环境变量

上方的 Path 双击 -> 新建 -> 输入你的 ffmpeg 的 bin 文件夹全路径 即可。

比如我的是 `E:\worksofts\__media\ffmpeg\bin`

![ffmpeg 环境变量设置方法](https://user-images.githubusercontent.com/37037844/170719677-eb2c9c9a-252c-44f1-a0d4-4ce42c427a93.png)
