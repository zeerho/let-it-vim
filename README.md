# LetItVim

## 简介

**LetItVim** 是一款基于 AutoHotKey （以下简称 AHK） 来实现的辅助软件，旨在使用类 Vim 的方式来操作计算机。

此程序的最初灵感来自于 [vimdesktop](https://github.com/goreliu/vimdesktop/wiki)。后由于想要修改一部分功能，而重构工作量较大，故决定不在 vimdesktop 的基础上修改，而是另起炉灶。

在编写过程中，吸收了 vimdesktop 中的不少优秀设计，同时也参考了其中的一部分代码实现。故特此感谢 [vimdesktop 作者](https://github.com/goreliu) 以及其他所有贡献者。

## 使用说明

1. 确保已安装 AHK。
2. 双击运行软件根目录下的 `let_it_vim.ahk`。
3. 默认的快捷键功能见 `config.ini`。

### 配置

可自行修改软件根目录下的 `config.ini`。其中，

1. 快捷键使用 AHK 原生的表示方式，故需要使用者对 AHK 有基本的了解。（此后的版本明确不会加入原生表示方式和用户友好表示方式之间转换的功能）
2. 对于某些因环境而异的配置（比如家中和公司电脑的一些程序路径不同），可以通过在配置前加上 `(profile:{activeProf})` 来加以区分。其中 `{activeProf}` 的值为系统环境变量中的 `AHK_PROFILE` 的值（该环境变量需自行设置）。

### 插件

所有插件脚本位于 `/plugin` 文件夹下。通过在 `/plugin/plugins_include.ahk` 中增删 `#Include` 语句来启用/停用指定插件。

后续计划改成在 `config.ini` 中的 `[plugin]` 里配置插件的开关状态。

## 其他

欢迎 Issue 和 PR，但是由于此项目目前的主要需求是面向我个人的，故我可能在解决/合并时有所挑选。:P

## TODO

- [ ] 根据配置中各插件是否启用来动态改变 #INCLUDE（暂时通过手动修改 plugin/plugins_include.ahk 来实现）
- [ ] 屏蔽普通模式和选择模式下未映射的所有按键
- [ ] 通过配置来设置连续键
- [ ] 连续键还有缺陷
- [ ] 加入命令模式功能
- [ ] 对于按键 0 的热键映射无法生效，因为在函数中 0 会被当成 false
- [ ] 对标签进行归类整理