set(EXECUTABLE_OUTPUT_PATH ${CMAKE_BINARY_DIR})
set(LIBRARY_OUTPUT_PATH ${CMAKE_BINARY_DIR}/lib)

if(APPLE)
  include_directories(/opt/local/include) # MacPorts
  find_library(OPENGL_LIBRARY OpenGL)
else()
  find_library(OPENGL_LIBRARY GL)
  find_library(GLU_LIBRARY GLU)
  set(OPENGL_LIBRARY ${OPENGL_LIBRARY} ${GLU_LIBRARY})
endif()

find_library(EXPAT_LIBRARY expat)
find_library(GLUT_LIBRARY glut)

include(FindPkgConfig)

find_package(Qt4 4.4 COMPONENTS QtCore QtGui QtOpenGL Qt3Support QtNetwork)
pkg_search_module(EIGEN3 REQUIRED eigen3>=3)

include_directories(${EIGEN3_INCLUDE_DIRS})

if (QT_FOUND)
  add_definitions(${QT_DEFINITIONS})
  if (QT4_FOUND)
    add_definitions(-DMZ_HAVE_QT4)
    include(${QT_USE_FILE})
  endif (QT4_FOUND)
endif (QT_FOUND)

set(CMAKE_C_FLAGS "-Wall -g")
set(CMAKE_CXX_FLAGS "-Wall -g")

if(APPLE)
  set(CMAKE_C_FLAGS "${CMAKE_C_FLAGS} -Wsign-compare")
  set(CMAKE_CXX_FLAGS "${CMAKE_C_FLAGS} -Wsign-compare")
endif()

set(CMAKE_C_FLAGS_DEBUG "-O")
set(CMAKE_CXX_FLAGS_DEBUG "-O")

set(CMAKE_C_FLAGS_RELEASE "-O2")
set(CMAKE_CXX_FLAGS_RELEASE "-O2")

macro(add_gui_app name)
  if(APPLE)
    add_executable(${name} MACOSX_BUNDLE ${ARGN})
  else()
    add_executable(${name} ${ARGN})
  endif()
endmacro(add_gui_app)

