include(vcpkg_common_functions)
vcpkg_download_distfile(ARCHIVE
    URL "https://github.com/assimp/assimp/archive/v3.3.1.zip"
    FILENAME "assimp-3.3.1.zip"
    MD5 c20ae75c10d1569cd6fa435eef079f56
)
vcpkg_extract_source_archive(${ARCHIVE})

vcpkg_configure_cmake(
    SOURCE_PATH ${CURRENT_BUILDTREES_DIR}/src/assimp-3.3.1
    OPTIONS -DASSIMP_BUILD_ASSIMP_TOOLS=OFF
    # OPTIONS_RELEASE -DOPTIMIZE=1
    # OPTIONS_DEBUG -DDEBUGGABLE=1
)

vcpkg_build_cmake()
vcpkg_install_cmake()

# Handle copyright
file(COPY ${CURRENT_BUILDTREES_DIR}/src/assimp-3.3.1/LICENSE DESTINATION ${CURRENT_PACKAGES_DIR}/share/assimp)
file(RENAME ${CURRENT_PACKAGES_DIR}/share/assimp/LICENSE ${CURRENT_PACKAGES_DIR}/share/assimp/copyright)
