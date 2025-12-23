@echo off
echo Starting Jekyll server on all network interfaces (including public IP)...
jekyll serve --host 0.0.0.0 --port 4000 --livereload
pause


#jekyll serve --host localhost --port 4000
#cd yz/Matrix_Lab/Matrix_Lab1.0 && jekyll serve --host 0.0.0.0 --port 4000 &


cd yz/Matrix_Lab/Matrix_Lab1.0 && ./start_server.sh

Starting Jekyll server on all network interfaces (including public IP)...
Server will continue running even after closing terminal/VSCode
To stop the server, run: pkill -f 'jekyll serve'
Jekyll server started in background
Logs are being written to: jekyll.log
Check if server is running with: ps aux | grep jekyll
View logs with: tail -f jekyll.log
Server URL: http://0.0.0.0:4000


下面是启动命令：
cd /root/yz/Matrix_Lab/Matrix_Lab1.0 && nohup jekyll serve --host 0.0.0.0 --port 4000 --skip-initial-build > /root/jekyll.log 2>&1 &

cd /root/yz/Matrix_Lab/Matrix_Lab1.0 && nohup python3 admin-server.py > /root/admin-server.log 2>&1 &