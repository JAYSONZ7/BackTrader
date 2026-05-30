cmake_minimum_required(VERSION 3.15)
project(TEST_CASE LANGUAGES CXX)

set(CMAKE_CXX_STANDARD 17)
set(CMAKE_CXX_STANDARD_REQUIRED ON)

MESSAGE(STATUS "CMAKE_SOURCE_DIR = ${CMAKE_SOURCE_DIR}")
MESSAGE(STATUS "CMAKE_BINARY_DIR = ${CMAKE_BINARY_DIR}")

IF(WIN32)
    MESSAGE(STATUS "##########OS is WINDOWS##########")
ELSEIF(UNIX)
    MESSAGE(STATUS "##########OS is UNIX-like OS's##########")
    MESSAGE(STATUS "${CMAKE_SOURCE_DIR}")

ENDIF()

# 源文件收集
file(GLOB THIRD_PARTY_INCLUDE ${CMAKE_SOURCE_DIR}/src/third_party/rapidjson/include/*.h)
file(GLOB TEST_SRC ${CMAKE_SOURCE_DIR}/src/testjson/*.cpp)

# 创建可执行文件
add_executable(testjson ${TEST_SRC})

# 设置包含目录
target_include_directories(testjson PUBLIC ${THIRD_PARTY_INCLUDE})

# 使可执行文件依赖于clean_bin目标
add_dependencies(testjson clean_bin)
