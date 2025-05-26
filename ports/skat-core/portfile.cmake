set(VCPKG_POLICY_SKIP_COPYRIGHT_CHECK enabled)

file(READ "${CMAKE_CURRENT_LIST_DIR}/vcpkg.json" vcpkg_json)
string(JSON pkgname GET "${vcpkg_json}" "name")
string(JSON version GET "${vcpkg_json}" "version")

if(CMAKE_HOST_SYSTEM_NAME STREQUAL "Darwin")
  set(platform "Darwin")
elseif(CMAKE_HOST_SYSTEM_NAME STREQUAL "Linux")
  set(platform "Linux")
elseif(CMAKE_HOST_SYSTEM_NAME STREQUAL "Windows")
  set(platform "win64")
else()
  message(FATAL_ERROR "unsupported platform: ${CMAKE_HOST_SYSTEM_NAME}")
endif()

set(archive_filename "${pkgname}-${version}-${platform}.tar.gz")
set(archive_url "https://github.com/dusunim/${pkgname}/releases/download/release%2F${version}/${archive_filename}")

vcpkg_download_distfile(
  archive_path
  URLS ${archive_url}
  FILENAME ${archive_filename}
  SKIP_SHA512
)

vcpkg_extract_source_archive(
  extracted_path ARCHIVE
  ${archive_path}
)

file(INSTALL ${extracted_path}/include/
  DESTINATION ${CURRENT_PACKAGES_DIR}/include)

file(INSTALL ${extracted_path}/lib/
  DESTINATION ${CURRENT_PACKAGES_DIR}/lib)

if(EXISTS "${extracted_path}/bin")
  file(INSTALL ${extracted_path}/bin/
    DESTINATION ${CURRENT_PACKAGES_DIR}/bin)
endif()

file(INSTALL ${extracted_path}/lib/cmake/${pkgname}/
  DESTINATION ${CURRENT_PACKAGES_DIR}/share/${pkgname})
