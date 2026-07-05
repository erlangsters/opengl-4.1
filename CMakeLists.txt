cmake_minimum_required(VERSION 3.11)
project(beam_gl LANGUAGES C)

set(CMAKE_C_STANDARD 17)
set(CMAKE_C_STANDARD_REQUIRED ON)

if(NOT DEFINED ERLANG_ERTS_DIR)
    message(FATAL_ERROR "ERLANG_ERTS_DIR must be defined (pass -DERLANG_ERTS_DIR=...)")
endif()
if(NOT DEFINED ERL_INTERFACE_DIR)
    message(FATAL_ERROR "ERL_INTERFACE_DIR must be defined (pass -DERL_INTERFACE_DIR=...)")
endif()

if(APPLE OR WIN32)
    if(NOT DEFINED ANGLE_INCLUDE_DIR)
        message(FATAL_ERROR "ANGLE_INCLUDE_DIR must be defined (pass -DANGLE_INCLUDE_DIR=...)")
    endif()
    if(NOT DEFINED ANGLE_LIB_DIR)
        message(FATAL_ERROR "ANGLE_LIB_DIR must be defined (pass -DANGLE_LIB_DIR=...)")
    endif()
endif()

set(ERTS_INCLUDE_DIR "${ERLANG_ERTS_DIR}/include")
set(ERL_INTERFACE_INCLUDE_DIR "${ERL_INTERFACE_DIR}/include")
set(ERL_INTERFACE_LIB_DIR "${ERL_INTERFACE_DIR}/lib")

include_directories(
    ${ERTS_INCLUDE_DIR}
    ${ERL_INTERFACE_INCLUDE_DIR}
    c_src/include
)
link_directories(${ERL_INTERFACE_LIB_DIR})

if(APPLE OR WIN32)
    include_directories(${ANGLE_INCLUDE_DIR})
    link_directories(${ANGLE_LIB_DIR})
endif()

add_library(beam-gl SHARED
    c_src/gl.c
    c_src/glad.c
)

set_target_properties(beam-gl PROPERTIES
    OUTPUT_NAME "beam-gl"
    PREFIX ""
    LIBRARY_OUTPUT_DIRECTORY "${CMAKE_CURRENT_SOURCE_DIR}/priv"
    RUNTIME_OUTPUT_DIRECTORY "${CMAKE_CURRENT_SOURCE_DIR}/priv"
)

if(APPLE)
    set_target_properties(beam-gl PROPERTIES
        LINK_FLAGS "-flat_namespace -undefined suppress"
        SUFFIX ".so"
    )
endif()

target_link_libraries(beam-gl PRIVATE ei ${CMAKE_DL_LIBS})
