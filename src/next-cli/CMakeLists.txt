get_filename_component(target_name ${CMAKE_CURRENT_SOURCE_DIR} NAME)
file(GLOB_RECURSE src_files CONFIGURE_DEPENDS *.cpp *.h)

add_executable(${target_name} ${src_files} ${include_files})
cp_executable_settings(${target_name} "apps")

if(NOT DEFINED ENV{EMBEDDING_TARGET})
    find_package(skat-core CONFIG REQUIRED)
    target_link_libraries(${target_name} PRIVATE skat-core::foundation)
else()
    target_link_libraries(${target_name} PRIVATE foundation)
    target_include_directories(${target_name} PUBLIC ${CMAKE_SOURCE_DIR}/skat-core/include)
endif()
