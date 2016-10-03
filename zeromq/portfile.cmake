include(vcpkg_common_functions)
set(PORT_VERSION "4.1.5")
set(SOURCE_PATH ${CURRENT_BUILDTREES_DIR}/src/zeromq-${PORT_VERSION})
vcpkg_download_distfile(ARCHIVE
    URL "https://github.com/zeromq/zeromq4-1/releases/download/v${PORT_VERSION}/zeromq-${PORT_VERSION}.zip"
    FILENAME "zeromq-${PORT_VERSION}.zip"
    SHA512 4e531496b18958750e4807759a1d59e97c59853719dc2d016666b031275cd66197370b5387504c87971551a4a4c3a498908bf783f4bbfa18f1df606bde5c05c7
)
vcpkg_extract_source_archive(${ARCHIVE})

# Workaround for issue https://github.com/zeromq/libzmq/pull/2097
# Should be solved when 4.1.6 is released
file(COPY ${CMAKE_CURRENT_LIST_DIR}/src/version.rc.in DESTINATION ${SOURCE_PATH}/src)

vcpkg_configure_cmake(
    SOURCE_PATH ${SOURCE_PATH}
    OPTIONS -DZMQ_BUILD_TESTS=OFF
)

vcpkg_build_cmake()
vcpkg_install_cmake()

# Cleanup debug includes 
file(REMOVE_RECURSE ${CURRENT_PACKAGES_DIR}/debug/include)

# Cleanup exes 
file(GLOB EXES_TO_REMOVE ${CURRENT_PACKAGES_DIR}/bin/*exe ${CURRENT_PACKAGES_DIR}/debug/bin/*exe)
file(REMOVE ${EXES_TO_REMOVE})

# Cleanup installed sources 
file(REMOVE_RECURSE ${CURRENT_PACKAGES_DIR}/src)
file(REMOVE_RECURSE ${CURRENT_PACKAGES_DIR}/debug/src)

# Handle copyright
file(COPY ${SOUCE_PATH}/COPYING.LESSER DESTINATION ${CURRENT_PACKAGES_DIR}/share/zeromq)
file(RENAME ${CURRENT_PACKAGES_DIR}/share/zeromq/COPYING.LESSER ${CURRENT_PACKAGES_DIR}/share/zeromq/copyright)

# Remove installed *txt files 
file(GLOB TXTS_TO_REMOVE ${CURRENT_PACKAGES_DIR}/*txt ${CURRENT_PACKAGES_DIR}/debug/*txt)
file(REMOVE ${TXTS_TO_REMOVE})
