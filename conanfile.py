from conan import ConanFile
from conan.tools.cmake import CMakeToolchain, CMake, cmake_layout, CMakeDeps
import os

class hivemindRecipe(ConanFile):
    name = "hivemind"
    version = "0.0.1"

    author = "Jerome Hufford jerome.hufford@gmail.com"
    url = "https://gitlab.xemplify.net/jmhufford/code-challenge"
    description = "Hivemind Build & Release Take-Home Challenge"

    # Binary configuration
    settings = "os", "compiler", "build_type", "arch"

    # Sources are located in the same place as this recipe, copy them to the recipe
    exports_sources = "CMakeLists.txt", "src/*", "README.md"

    def requirements(self):
        self.requires("imath/3.1.12")

    def layout(self):
        cmake_layout(self)

    def generate(self):
        deps = CMakeDeps(self)
        deps.generate()
        tc = CMakeToolchain(self)
        tc.generate()

    def build(self):
        cmake = CMake(self)
        cmake.configure()
        cmake.build()

    def package(self):
        cmake = CMake(self)
        cmake.install()

    def package_info(self):
        self.cpp_info.components["brain"].set_property("cmake_file_name", "Brain")
        self.cpp_info.components["brain"].libs = ["brain"]
        self.cpp_info.components["brain"].includedirs = ["include/brain"]

        self.cpp_info.components["thoughts"].set_property("cmake_file_name", "Thoughts")
        self.cpp_info.components["thoughts"].includedirs = ["include/thoughts"]

        self.runenv_info.prepend_path("PATH", os.path.join(self.package_folder, "bin"))


    
