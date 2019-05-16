
#### 安装Chocolatey

- 以管理员身份运行CMD:

	[Chocolatey官网](https://chocolatey.org/install)

	`
	@powershell -NoProfile -ExecutionPolicy Bypass -Command "iex ((New-Object System.Net.WebClient).DownloadString('https://chocolatey.org/install.ps1'))" && SET "PATH=%PATH%;%ALLUSERSPROFILE%\chocolatey\bin"
	`
	
	![](/images/Chocolateyinstall.png)

- 检查安装情况

	`chocolatey help`

	![](/images/Chocolateyinstall1.png)
	
	`choco feature enable -n useFipsCompliantChecksums`

	![](/images/Chocolateyinstall2.png)

- 添加seuic源

	```
		choco source add -n=seuic -s"http://choco.seuic.info/nuget/" 
		choco source remove -n=chocolatey
		choco source add -n=chocolatey -s"https://chocolatey.org/api/v2/"  --priority=3
	```
	![](/images/Chocolateyinstall3.png)



#### 安装androidstudio
androidstudio依赖android-sdk和jdk8,android-sdk依赖jdk8。

choco安装时会自动安装依赖:`cinst androidstudio -y -s"seuic"`

![](/images/Chocolateyinstall4.png)


#### DownLoading components for androidstudio 及 Setting 

根据chocolatey安装命令行报告找到Android SDK正确安装位置进行安装
并配置ANDROID_HOME环境变量路径

#### 安装Python2

	`choco install python2`

#### 安装React Native的命令行工具（react-native-cli）

`npm install -g react-native-cli`

#### 环境变量配置
ANDROID_HOME `C:\Users\USERNAME\AppData\Local\Temp\chocolatey\android-sdk\24.4.1.2`

adb `C:\Users\USERNAME\AppData\Local\Temp\chocolatey\android-sdk\24.4.1.2\platform-tools`

android-sdk `C:\Users\USERNAME\AppData\Local\Temp\chocolatey\android-sdk\24.4.1.2`

android-sdk/tools `C:\Users\USERNAME\AppData\Local\Temp\chocolatey\android-sdk\24.4.1.2\tools`

jdk8 `C:\Program Files\Java\jdk1.8.0_102`

#### 安装Genymotion

登陆官网，注册账号，下载带有VBox的安装包

[安装Genymotion教程](http://jingyan.baidu.com/article/8ebacdf02a5c3649f65cd5f0.html)
