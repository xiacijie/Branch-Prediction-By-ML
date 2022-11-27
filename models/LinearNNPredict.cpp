#include <torch/script.h>
#include <string>

std::string getEnv(const std::string& var ) {
    const char * val = std::getenv( var.c_str() );
    if ( val == nullptr ) { // invalid to assign nullptr to std::string
        return "";
    }
    return val;
}

int main(int argc, const char* argv[]) {
    torch::jit::script::Module module;
    // try {
        // Deserialize the ScriptModule from a file using torch::jit::load().
    module = torch::jit::load(getEnv("MODEL_ROOT") + "/LinearNN.pt");
    // }
    // catch (const c10::Error& e) {
    //     std::cerr << "error loading the model\n";
    //     return -1;
    // }

    std::cout << "ok\n";
    return 1;
}