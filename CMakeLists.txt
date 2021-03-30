cmake_minimum_required(VERSION 3.1)
##project (GL C CXX)

# Compile C++ files with C++14
set (CMAKE_CXX_STANDARD 14)

# Specify where to put all the RUNTIME target files when built.
set(CMAKE_LIBRARY_OUTPUT_DIRECTORY ${CMAKE_BINARY_DIR}/lib)
set(CMAKE_ARCHIVE_OUTPUT_DIRECTORY ${CMAKE_BINARY_DIR}/lib)
set(CMAKE_RUNTIME_OUTPUT_DIRECTORY ${CMAKE_BINARY_DIR}/bin)

# Add include directories to the build.
include_directories (include)

# Copy user libraries into the build folder
if(EXISTS "${CMAKE_SOURCE_DIR}/lib" AND IS_DIRECTORY "${CMAKE_SOURCE_DIR}/lib")
    file(GLOB_RECURSE libraries
        "lib/*${CMAKE_SHARED_LIBRARY_SUFFIX}"
        "lib/*${CMAKE_STATIC_LIBRARY_SUFFIX}"
    )

    foreach(library IN LISTS libraries)
        file(COPY ${library} DESTINATION ${CMAKE_LIBRARY_OUTPUT_DIRECTORY})
    endforeach()

    file(GLOB_RECURSE libraries
        "${CMAKE_LIBRARY_OUTPUT_DIRECTORY}/*${CMAKE_SHARED_LIBRARY_SUFFIX}"
        "${CMAKE_LIBRARY_OUTPUT_DIRECTORY}/*${CMAKE_STATIC_LIBRARY_SUFFIX}"
    )
endif()

# Recurse into the "src" subdirectory. This does not actually
# cause another cmake executable to run. The same process will walk through
# the project's entire directory structure.
add_subdirectory (src)
