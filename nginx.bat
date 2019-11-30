@echo off

title %username%-Nginx
mode con cols=50 lines=15

set status=0

:menu

cls

if %status%==1 title Nginx已开启
if %status%==2 title Nginx已重载
if %status%==3 title Nginx已关闭
if %status%==4 title 错误指令

@echo 1：启动nginx
@echo 2：重载nginx配置文件
@echo 3：停止nginx
@echo 5：打开配置文件
@echo 6：检测配置文件

@echo.

set /p param=请输入对应指令编号：

if %param%==1 (goto startNginx)^
else if %param%==2 (goto reloadConfig)^
else if %param%==3 (goto stopNginx)^
else if %param%==5 (goto openConfig)^
else if %param%==6 (goto checkConfig)^
else goto error

::错误输入
:error
	set /a status=4
	goto menu

::开启Nginx
:startNginx
	title 启动中...
	::判断nginx是否在运行
	tasklist | find /i "nginx.exe" >nul
	::如果没运行则开启nginx
	if %errorlevel%==1 start nginx
	set /a status=1
	choice /t 1 /d y /n >nul
	goto menu

::重载nginx配置文件
:reloadConfig
	title 重载中...
	nginx -s reload
	set /a status=2
	goto menu

::关闭Nginx
:stopNginx
	title 关闭中...
	::nginx -s quit
	taskkill /F /IM nginx.exe > nul
	set /a status=3
	goto menu

::打开Nginx配置文件
:openConfig
	start "" "./conf/nginx.conf"
	goto menu

::检测Nginx配置文件
:checkConfig
	nginx -t
	pause
	goto menu