cmake_minimum_required(VERSION 3.15)
project(PackageTest CXX)

find_package(hivemind CONFIG REQUIRED)

add_executable(tester tester.cpp)
target_link_libraries(tester hivemind::thoughts hivemind::brain)
