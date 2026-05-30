# 设置颜色
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
NC='\033[0m' # No Color

echo "========================================"
echo "    CMake 项目构建脚本 (macOS)"
echo "========================================"

# 检查CMake是否安装
if ! command -v cmake &> /dev/null; then
    echo -e "${RED}错误: 未找到CMake!${NC}"
    echo "请使用以下命令安装CMake:"
    echo "  brew install cmake  # 通过Homebrew安装"
    echo "  或从 https://cmake.org/download/ 下载安装"
    exit 1
fi

# 检查是否安装了Homebrew的CMake
CMAKE_VERSION=$(cmake --version | head -n1)
echo "使用: $CMAKE_VERSION"

# 检查编译器
echo -e "\n检查编译器..."
if command -v clang++ &> /dev/null; then
    CLANG_VERSION=$(clang++ --version | head -n1)
    echo "编译器: $CLANG_VERSION"
else
    echo -e "${YELLOW}警告: 未找到clang++编译器${NC}"
    echo "Xcode命令行工具可能未安装"
    echo "请运行: xcode-select --install"
fi

# 清理之前的构建
if [ -d "build" ]; then
    echo -e "\n清理之前的构建文件..."
    rm -rf build
fi

# 创建构建目录
echo -e "\n创建构建目录..."
mkdir -p build
cd build

echo -e "\n正在配置CMake项目..."

# 执行CMake配置
cmake .. -DCMAKE_BUILD_TYPE=Release
if [ $? -ne 0 ]; then
    echo -e "\n${RED}CMake配置失败!${NC}"
    cd ..
    exit 1
fi

echo -e "\nCMake配置成功!" 

# 重新配置为指定构建类型
cmake .. -DCMAKE_BUILD_TYPE=Release
echo -e "\n正在构建项目..."

# 执行构建 (使用所有CPU核心)
NPROC=$(sysctl -n hw.ncpu)
echo "使用 $NPROC 个CPU核心进行编译..."
make -j$NPROC

if [ $? -ne 0 ]; then
    echo -e "\n${RED}构建失败!${NC}"
    cd ..
    exit 1
fi

# 返回项目根目录
cd ..

echo -e "\n${GREEN}构建成功完成!${NC}"
echo "========================================"

echo -e "\n${GREEN}脚本执行完成!${NC}"