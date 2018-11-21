
---

title: 从零开始学黑苹果-进阶安装教程(10.12.6)
tag: 
  - Hackintosh 
categories: Technology  
clearReading: true
date: 2017-03-30 20:10:31
favicon: huangyz0918.github.io/assets/images/cat.png 
thumbnailImage: https://i.loli.net/2017/10/10/59dce63bdaff6.png 
thumbnailImagePosition: right 
autoThumbnailImage: yes
metaAlignment: center
comments: true 
summary: 处女座晚期患者追求完美的自虐旅程

---


<!-- more -->

### 本文目录
#### 1. 简述
#### 2. 黑苹果(Hackintosh)安装教程
 - 原有黑苹果基础升级macOS Serria
 - U盘完整安装黑苹果
#### 3. Serria 系统驱动教程
- 声卡驱动
- 集成显卡驱动
#### 4. 提取 DSDT 修改教程


***
###1. 简述
10.12 的安装流程与 10.11 安装流程相似，总的来说安装镜像还是分为原版，懒人版，整合版。在这里我们介绍原版苹果系统的安装。对于黑苹果的一些安装基础，我这里就不赘述了，推荐大家先看我之前写的一篇文章作为基础：
[从零开始学黑苹果-基础安装教程(10.11.6)](http://www.jianshu.com/p/529392e7b0f6)

![10.12.6](http://upload-images.jianshu.io/upload_images/2779067-fd5aa9dc0b4ec529.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)
***
###2.黑苹果(Hackintosh)安装教程
#### <1>. 原有黑苹果基础升级macOS Serria
看过我之前那篇教程的朋友可能已经装好了macOS X ，那么新版本的Serria 出来了，是不是有种升级的冲动？黑苹果的升级虽然说不像白苹果升级那样简单，但是只要掌握了方法，利用Clover Bootloader 我们也可以很简单地完成黑苹果的升级。而且不需要创建新的USB安装介质。

首先，去Clover 官网更新Clover Bootloader [官网](https://sourceforge.net/projects/cloverefiboot/files/)
更新Clover 可以选择直接解压新版镜像到ESP分区，同时手动迁移原有引导文件，也可以直接使用.pkg安装文件，这里我们推荐后者。

更新完bootloader以后，我们要确保ESP分区安装好了一些必不可少的驱动(kexts)。打开Clover Configurator，点击左侧 "Mount EFI" 挂载EFI分区：

![Mount EFI](http://upload-images.jianshu.io/upload_images/2779067-4c2cad0022897d05.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

挂载EFI分区以后，进入EFI分区：` /EFI/CLOVER/kexts/Other/` 拷贝适用于Hackintosh 10.12 的 __FackSMC.kext__ 和一些必要的kext 进去。如果你的系统需要__essential kexts__，可以点击这个链接下载：[下载](http://www.tonymacx86.com/resources/categories/kexts.11/)

这样就完成了启动引导器的设置，如果还不能正常引导进入系统则可能是集成显卡配置文件设置的问题，不同macOS版本黑苹果对于某些型号的集成显卡，配置文件会有些许不同，所以需要实现找好对应的显卡配置文件。

接下来进入原有的苹果系统下，进入APP store 下载macOS 安装App。
下载好以后直接打开，选择你的系统盘进行安装。
![macOS 安装](http://upload-images.jianshu.io/upload_images/2779067-9bb679c8b5fa6aac.209886?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

安装完成以后系统会提示你重启，重启，进入 clover bootloader。注意，安装完成以后原来的这个 App 将自动删除。

当进入 clover bootloader 时，你会发现启动项在原有的基础上增加了一个 "Boot macOS Install from XXX" (XXX 是你原有的系统启动盘，也就是老版黑苹果的系统盘)，这个是安装更新用的。如果你选择了原来的启动盘启动，那么计算机将直接启动到原来的老系统而不是继续更新。

选择"Boot macOS Install from XXX"，按下空格键，这个时候应该会显示clover关于这个启动项的设置。在 __"Without Caches"__ 或 __"Inject Kexts"__ 选项上面打勾，然后 __"Boot Mac OS X with selected options"__ 启动 macOS 安装。（注意有的版本 Clover 没有上述选项，如果没有的话就不需要勾选，直接启动即可）

完成安装以后系统将自动重启，重启以后你会发现 "Boot macOS Install from XXX" 的启动项消失了，这时从原来的启动项启动计算机，就可以进入升级以后的系统啦。



#### <2>.U盘完整安装黑苹果
##### UEFI + GPT 分区表的安装U盘制作

> ######  准备
> - 8GB 以上的U盘一个
> - 已经装好的黑苹果或者是白苹果一台（随便借也行）
> - Unibeast 软件  [下载](https://www.tonymacx86.com/resources/unibeast-7-1-1.333/)

如果找到了懒人版的安装镜像(镜像后缀为.cdr)，那么可以使用上述的HDD烧写工具: HDD Raw Copy Tool 直接选中镜像和U盘进行烧写。
但是这里我们将介绍直接安装原版 (App store 版) 的方法。
首先我们需要原版的安装镜像，这个直接去你的 APP Store 里面下载（前提是你有一个10.11的黑苹果或者是借用其他人的白苹果完成安装U盘的制作）

直接点击 macOS Serria 最新版本下载。这样，你的应用程序里面会多出一个"安装macOS"的应用。

![10.12.6](http://upload-images.jianshu.io/upload_images/2779067-2f28a889bed727cf.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

下载好了以后，使用我们之前下载好的 Unibeast 软件：
![Unibeast](http://upload-images.jianshu.io/upload_images/2779067-621eaeb79b61e51b.151384?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

注意，要使用下载 macOS 原版镜像的电脑制作，如果单单是把安装镜像拷贝到另外一台电脑上制作，由于两台电脑登陆的 Apple ID 不同，会导致安装U盘的制作失败。另外一点，Unibeast 软件打开前要记得将自己的电脑系统语言设置为英文，不然无法打开该软件。


![设置语言](http://upload-images.jianshu.io/upload_images/2779067-dfe90193e6caec1d.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

插入你要制作的U盘，先打开系统自带的“磁盘工具”，将原来的U盘格式化为苹果系统：Mac OS 扩展(日志式)。
然后打开 Unibeast 选择你的U盘作为使用对象。

![Unibeast 选择U盘](http://upload-images.jianshu.io/upload_images/2779067-5f8600c76283a5b2.212543?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

一路选择下一步，到了选择安装启动U盘引导格式的地方：

![Unibeast 选择引导](http://upload-images.jianshu.io/upload_images/2779067-d671f962d621ce7d.212542?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

在这里，就像我们之前说的一样。你可以选择EFI模式（UEFI Boot Mode）或者是传统模式引导（Legacy Boot Mode），如果你的电脑启动盘有ESP分区，就选择 UEFI，没有的话就选择传统模式引导，这里我们选择 UEFI Boot Mode。具体区分可以看上面的教程或者自己搜索。
选择镜像时，选择你刚才从 App Store下载的 macOS Serria 镜像。最后出现这个确认界面：

![Unibeast 确认界面](http://upload-images.jianshu.io/upload_images/2779067-e96eb8f576aba44f.212541?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

点击继续开始启动U盘的制作，耐心等待安装的完成。

![安装中...](http://upload-images.jianshu.io/upload_images/2779067-64614e1aeffba236.152904?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

这样，我们的安装U盘就制作完成啦。

#### macOS 的安装

我当时进入苹果的安装界面花了好久才成功。这说明了一点，引导Clover里面的配置文件是能否进入安装界面的关键。而这个关键之关键就是显卡。如果安装界面出现了问题，其中一半以上的概率是配置文件不符合显卡要求，或者是无法正确的识别显卡（集成显卡）。

这一点 Unibeast 制作好的U盘有提供一个“万能”的 Clover 安装配置文件，一般设备都能进入安装界面从而完成安装。但是也不排除利用 Unibeast 制作的U盘无法进入或是进入缓慢（最后卡在鼠标或者安装首界面的情况）。现在分析几种情况和解决方法：

 ##### 状况1:电脑开机启动的时候找不到苹果安装U盘启动选项
这种情况导致的可能很多，我们不去追究，但是找不到安装U盘的启动项意味着安装无法正常开始，那怎么办？按照之前安装10.11的方法，我们用Windows 把 Clover 安装进硬盘，从本地的 Clover 启动电脑，这样就能看到我们制作的10.12启动U盘了。但是将 Clover 安装进入电脑本地硬盘，为了达到和直接从U盘启动 Clover 一样的效果，我们要从U盘中提取一模一样的
 Clover 启动引导来安装。

利用一些能够挂载苹果 HFS+ 格式的工具挂载U盘，将U盘 EFI 分区中的Clover 拷贝至本地硬盘的EFI分区即可。或者是直接将U盘插入胖 macOS 系统，直接从白苹果（或黑苹果）里面操作。直到完成U盘中 Clover 分区的移植。

##### 状况2: 开机进入不了安装界面
- 开机很慢，等半天还是在开机苹果logo进度条上：
    这种情况如果尝试开机好几次都很慢，无法进入安装界面的话说明Clover里面的显卡配置文件不行。可以从 Rehabman 的Github(上文中有下载链接)下载对应你电脑型号的 config.plist 配置文件，替换启动Clover里的config.plist 文件即可。
- 开机直接失败，要么显示禁止符号或者是刷代码然后自动重启：
  这种情况，刷白屏代码意味着配置文件不对口，直接导致开机程序识别到未知的硬件（或者是显卡），用 Unibeast 制作的安装U盘出现这个问题一般是显卡配置文件不对。操作方法仍是修改电脑显卡配置文件。显示禁止符号意味着电脑直接给开机程序拒绝了，一般就不是显卡配置文件的问题了，但是仍有可能和显卡平台对应的`  ig-platform-id ` 等有关，修改 config.plist 文件，将平台，主板ID修改为正确的值。然后检查`  Clover/kexts ` 文件夹下面是否有驱动残缺，驱动多余等问题。一般使用 Unibeast 制作的安装U盘不会出现这个问题。如果出现，则可能是主板BIOS设置问题，请重启电脑进入主板BIOS设置（如何进入不同型号电脑不一致，上网搜索即可）修改BIOS设置，其中有几项需要注意：

> - 如果你的电脑BIOS有 __VT-d__ 选项（CPU选项），请选择禁用。
> - 如果你的电脑BIOS有 __CFG-Lock__ 选项（系统选项），请选择禁用。
> - 如果你的电脑BIOS有 __Secure Boot Mode__  选项（系统选项），请选择禁用。
> - 电脑设置OS 类型选择：__Other OS__
> - 如果你的电脑BIOS有 __IO SerialPort__ 选项（系统选项），请选择禁用。
> - 如果你的电脑有 __XHCI Handoff__ 选项，请选择开启。
> - 保存并退出BIOS设置

这样以来一般可以正常进入系统安装界面，完成系统的安装。

![安装界面](http://upload-images.jianshu.io/upload_images/2779067-0ffcf0eee3706170.152355?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

具体的安装方式与10.11安装无异，可以参考[黑苹果基础安装教程](http://www.jianshu.com/p/529392e7b0f6),安装完成以后系统会自动重启，重启以后启动项就会有macOS Serria的启动想了。这时系统的安装就完成了，先进入系统完成用户设置，具体的系统驱动还要下一步完成。
***
### 3. Serria 系统驱动教程
#### 驱动声卡进阶教程
现在驱动声卡一般有这么两种渠道：
- 使用第三方万能声卡驱动：VooDooHDA.kext
- 通过补丁驱动原生声卡：AppleHDA.kext

使用 VooDooHDA.kext 虽然方便，但是伴随着系统的升级，VooDooHDA.kext 容易引发与原生 AppleHDA.kext 的内核奔溃问题，这点我们在之前的教程里面也有提到过，可以通过删除系统自带 AppleHDA.kext 来达到，也可以通过 Clover 引导注入 AppleHDA.kext 的屏蔽驱动来达到驱动声卡的效果。

而驱动原生 AppleHDA.kext 可以避免上述的问题，而且还能够识别耳机输出设备，不需要手动切换输出设备（某些电脑对于 VooDooHDA.kext 得手动切换输入设备，相对日后使用来说比较麻烦）

而驱动原生也有缺点，很多的设备是不支持 AppleHDA.kext 的，所以就需要从 Clover 配置文件 config.plist 里面手动修改设备的声卡 ID 同时配合修改 DSDT 来完成驱动，这样以来相对驱动过程就很麻烦。


***
##### `本教程为进阶版本，关于黑苹果的安装基础，推荐先看：`
[从零开始学黑苹果-基础安装教程(10.11.6)](http://www.jianshu.com/p/529392e7b0f6)




##### ` 本教程纯属原创，转载请声明` 
##### ` 本文提供的链接若是失效请及时联系作者更新`
<!-- more -->