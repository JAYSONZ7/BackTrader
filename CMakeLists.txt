cmake_minimum_required(VERSION 3.15)
project(SERVER LANGUAGES CXX)

set(CMAKE_CXX_STANDARD 11)
set(CMAKE_CXX_STANDARD_REQUIRED ON)

# 设置输出目录
set(EXECUTABLE_OUTPUT_PATH ${PROJECT_SOURCE_DIR}/bin)

# 在构建前执行的命令
add_custom_target(clean_bin ALL
    COMMAND ${CMAKE_COMMAND} -E remove_directory ${EXECUTABLE_OUTPUT_PATH}
    COMMAND ${CMAKE_COMMAND} -E make_directory ${EXECUTABLE_OUTPUT_PATH}
    COMMENT "清理并创建bin目录: ${EXECUTABLE_OUTPUT_PATH}"
    WORKING_DIRECTORY ${CMAKE_CURRENT_SOURCE_DIR}
)

# 源文件收集
file(GLOB BASE_INCLUDE ${CMAKE_CURRENT_SOURCE_DIR}/src/base/*.h)
file(GLOB BASE_SRC ${CMAKE_CURRENT_SOURCE_DIR}/src/base/*.cpp)
file(GLOB SERVER_SRC ${CMAKE_CURRENT_SOURCE_DIR}/src/server/*.cpp)
file(GLOB CLIENT_SRC ${CMAKE_CURRENT_SOURCE_DIR}/src/client/*.cpp)

# 创建可执行文件
add_executable(client ${BASE_SRC} ${CLIENT_SRC})
add_executable(server ${BASE_SRC} ${SERVER_SRC})

# 设置包含目录
target_include_directories(client PUBLIC ${BASE_INCLUDE})
target_include_directories(server PUBLIC ${BASE_INCLUDE})

# 使可执行文件依赖于clean_bin目标
add_dependencies(client clean_bin)
add_dependencies(server clean_bin)