get_filename_component(target_name ${CMAKE_CURRENT_SOURCE_DIR} NAME)
file(GLOB_RECURSE src_files CONFIGURE_DEPENDS *.cpp *.h)

add_library(${target_name} SHARED ${src_files} ${include_files})
cp_common_settings(${target_name} "apps")

if(NOT DEFINED ENV{EMBEDDING_TARGET})
    find_package(skat-core CONFIG REQUIRED)
    target_link_libraries(${target_name} PRIVATE skat-core::foundation)
else()
    target_include_directories(${target_name} PUBLIC ${CMAKE_SOURCE_DIR}/skat-core/include)
endif()
