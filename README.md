
## 说明
该程序有3个目的，
1.用来验证 gcc编译在 64 位， 32 位，debug , release , assert 等方面的差异
2.用来验证 cmake构建 动态链接库，静态链接库，多目录的差异
3.用来验证 C 和 C++ 的差异

## 使用
64位编译32需要 apt-get install libc6-dev-i386
32位c++ 需要   cd /usr/lib32 && ln -s libstdc++.so.6 libstdc++.so

执行 testall.sh
