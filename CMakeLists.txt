cmake_minimum_required(VERSION 3.10)

include(${CMAKE_CURRENT_LIST_DIR}/cmake/config.cmake)

set_property(GLOBAL PROPERTY USE_FOLDERS ON)
set(CMAKE_CXX_STANDARD 17)
set(CMAKE_CXX_STANDARD_REQUIRED ON)
set(CMAKE_CXX_EXTENSIONS OFF)

if(NOT DEFINED ENV{EMBEDDING_TARGET})
  project(skat-app)
else()
  project(skat-app-bundled)

  add_subdirectory("$ENV{EMBEDDING_TARGET}")
endif()

add_subdirectory(src/next-cli)

if(CMAKE_SOURCE_DIR STREQUAL CMAKE_CURRENT_SOURCE_DIR)
  add_custom_target(
    check-format
    COMMAND clang-format --dry-run ${CPP_SOURCES}
    WORKING_DIRECTORY ${CMAKE_SOURCE_DIR}
    COMMENT "checking format in src..."
  )

  add_custom_target(
    format
    COMMAND clang-format -i ${CPP_SOURCES}
    WORKING_DIRECTORY ${CMAKE_SOURCE_DIR}
    COMMENT "checking format in src..."
  )

  set_target_properties(check-format PROPERTIES FOLDER "workflow")
  set_target_properties(format PROPERTIES FOLDER "workflow")
endif()
