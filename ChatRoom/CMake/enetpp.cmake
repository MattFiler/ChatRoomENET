OPTION(ENABLE_ENET "Adds Networking to the Project" OFF)

if(ENABLE_ENET)
    # fetch project
    include(FetchContent)
    FetchContent_Declare(
            enet
            GIT_REPOSITORY https://github.com/lsalzman/enet
            GIT_TAG        0eaf48eeb0d94a18d079378d8b76d588832ce838)

    FetchContent_GetProperties(enet)
    if(NOT enet_POPULATED)
        FetchContent_Populate(enet)
        add_subdirectory(${enet_SOURCE_DIR} ${enet_BINARY_DIR})
    endif()

    FetchContent_Declare(
            enetpp
            GIT_REPOSITORY https://github.com/MattFiler/enetpp
            GIT_TAG        2620176a238d30ee2ef8beaf07c3c5157809be5e)

    FetchContent_GetProperties(enetpp)
    if(NOT enetpp_POPULATED)
        FetchContent_Populate(enetpp)
    endif()

    add_library(enetpp INTERFACE)
    target_include_directories(
            enetpp
            INTERFACE SYSTEM
            ${enet_SOURCE_DIR}/include
            ${enetpp_SOURCE_DIR}/include)
    target_compile_options(
            enetpp
            INTERFACE
            $<$<COMPILE_LANGUAGE:CXX>:-w -fpermissive>)

    add_dependencies(enetpp enet)
    target_link_libraries(enetpp INTERFACE enet)
endif()

