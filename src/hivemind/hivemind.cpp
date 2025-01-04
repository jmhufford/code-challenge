#include "brain.h"
#include "thoughts.h"
#include <vector>
#include <string>

int main() {

    interval_checks();
    frustum_checks();

    hivemind();

    std::vector<std::string> vec;
    vec.push_back("test_package");

    hivemind_print_vector(vec);
}
