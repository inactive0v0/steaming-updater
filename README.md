# Steaming Updater - 蒸汽更新姬
一个可扩展的适用于各种steam游戏的Linux服务端的自动更新脚本

## 原理
运行steamcmd的更新命令，通过读取输出判断是否需要重启服务端；

适配screen和tmux两种运行服务端的后台shell（需指定）；

采用模块化设计，针对每种服务端编写restart函数即可扩展功能（欢迎PR）。

## 支持的服务端
| 服务端     | 插件名称 |
| ---------- | -------- |
| [饥荒联机版](https://github.com/inactive-virus/steaming-updater/wiki/%E6%8F%92%E4%BB%B6:%E9%A5%A5%E8%8D%92%E8%81%94%E6%9C%BA%E7%89%88) | dstds    |
| ……         | ……       |

## 使用方法

首先编辑`updater.conf`和`plugins/`目录下的对应conf文件，写入需要的信息（详见本repo的[Wiki](https://github.com/inactive-virus/steaming-updater/wiki)）；

运行：`./steaming_updater.sh <Shell> <Plugin>`

例：用于自动更新在tmux下运行的饥荒联机版服务器

`./steaming_updater.sh tmux dstds`

如运行正常，即可将其加入crontab中定时运行。

例：每小时执行一次自动更新脚本，并记录日志；

`0 * * * * ~/steaming_updater/steaming_updater.sh tmux dstds >> ~/steaming_updater/dstds.log 2>&1`
