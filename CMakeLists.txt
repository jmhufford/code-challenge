cmake_minimum_required(VERSION 3.23)

project(hivemindSDK
    VERSION 0.0.1
    LANGUAGES C CXX
    DESCRIPTION "Hivemind Build & Release Take-Home Challenge"
)

find_package(Imath)

add_library(thoughts INTERFACE)
target_include_directories(thoughts INTERFACE ${CMAKE_SOURCE_DIR}/src/thoughts)

add_library(brain
    SHARED
    ${CMAKE_SOURCE_DIR}/src/brain/brain.cpp
)
target_include_directories(brain PUBLIC ${CMAKE_SOURCE_DIR}/src/brain)
target_link_libraries(brain Imath::Imath)

add_executable(hivemind 
    ${CMAKE_SOURCE_DIR}/src/hivemind/hivemind.cpp
)
target_link_libraries(hivemind brain thoughts)
if(CMAKE_BUILD_TYPE STREQUAL "Release")
    # Enable RPATH for release builds
    set(CMAKE_SKIP_BUILD_RPATH FALSE)
    set(CMAKE_BUILD_WITH_INSTALL_RPATH FALSE)
    set(CMAKE_INSTALL_RPATH "$ORIGIN/../lib")
    set(CMAKE_INSTALL_RPATH_USE_LINK_PATH TRUE)

    # Set RPATH for the hivemind executable
    set_target_properties(hivemind PROPERTIES
        INSTALL_RPATH "$ORIGIN/../lib"
        BUILD_WITH_INSTALL_RPATH TRUE
    )

    # Set RPATH for the brain shared library
    set_target_properties(brain PROPERTIES
        INSTALL_RPATH "$ORIGIN"
        BUILD_WITH_INSTALL_RPATH TRUE
    )
endif()

install(TARGETS hivemind brain
    RUNTIME DESTINATION bin
    ARCHIVE DESTINATION lib
    LIBRARY DESTINATION lib
)

# Install the brain.h header file
install(FILES ${CMAKE_SOURCE_DIR}/src/brain/brain.h DESTINATION include/brain)

install(TARGETS thoughts EXPORT thoughtsTargets)

# Install the include directories for header-only library
install(DIRECTORY ${CMAKE_SOURCE_DIR}/src/thoughts/ DESTINATION include/thoughts)

# Packaging
set(CPACK_PACKAGE_NAME ${PROJECT_NAME}
    CACHE STRING "hivemind"
)
set(CPACK_PACKAGE_DESCRIPTION_SUMMARY "Hivemind Build & Release Take-Home Challenge"
    CACHE STRING "Hivemind Build & Release Take-Home Challenge"
)

set(CPACK_PACKAGE_VENDOR "Xemplify LLC")

set(CPACK_VERBATIM_VARIABLES YES)

set(CPACK_PACKAGE_INSTALL_DIRECTORY ${CPACK_PACKAGE_NAME})
SET(CPACK_OUTPUT_FILE_PREFIX "${CMAKE_SOURCE_DIR}/_packages")

set(CPACK_DEBIAN_PACKAGE_SHLIBDEPS ON)
set(CPACK_PACKAGING_INSTALL_PREFIX "/usr/local")

set(CPACK_PACKAGE_VERSION_MAJOR ${PROJECT_VERSION_MAJOR})
set(CPACK_PACKAGE_VERSION_MINOR ${PROJECT_VERSION_MINOR})
set(CPACK_PACKAGE_VERSION_PATCH ${PROJECT_VERSION_PATCH})

set(CPACK_PACKAGE_CONTACT "jerome.hufford@gmail.com")
set(CPACK_DEBIAN_PACKAGE_MAINTAINER "Jerome Hufford")

set(CPACK_RESOURCE_FILE_README "${CMAKE_CURRENT_SOURCE_DIR}/README.md")

set(CPACK_DEBIAN_FILE_NAME DEB-DEFAULT)
set(CPACK_COMPONENTS_GROUPING ALL_COMPONENTS_IN_ONE)#ONE_PER_GROUP)
set(CPACK_DEB_COMPONENT_INSTALL YES)

include(CPack)
