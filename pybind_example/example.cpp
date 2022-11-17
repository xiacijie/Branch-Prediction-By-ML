#include <pybind11/embed.h> 
#include <pybind11/numpy.h>

#include <vector>
#include <iostream>

using namespace pybind11::literals;
namespace py = pybind11;

int main() {
    py::scoped_interpreter guard{}; // start the interpreter and keep it alive
    py::print("Hello, World!"); // use the Python API

    // convert vector<float> into numpy array
    std::vector<float> v_float(100);
    py::array_t<float> np_arr({v_float.size()},v_float.data());

    // call numpy function from C++
    py::object numpy = py::module_::import("numpy");
    py::object shape = numpy.attr("shape");

    auto ret = shape(np_arr);

    py::print(py::str(ret));

    py::object subtract = numpy.attr("subtract");
    py::array_t<float> ret_2 = subtract(np_arr, 1);

    py::print(ret_2);

    auto r = ret_2.unchecked<1>();
    std::cout << r(1) << std::endl;
    return 0;
}