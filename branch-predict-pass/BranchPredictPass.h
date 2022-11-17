#ifndef LLVM_TRANSFORMS_INSTRUMENTATION_BRANCH_PREDICT_PASS
#define LLVM_TRANSFORMS_INSTRUMENTATION_BRANCH_PREDICT_PASS

#include "llvm/IR/PassManager.h"

namespace llvm {
    class BranchPredictPass : public PassInfoMixin<BranchPredictPass> {
    public:

        PreservedAnalyses run(Function &F, FunctionAnalysisManager &AM) {
            printf("Hello XXXXXXXXXXX!\n");
            return PreservedAnalyses::all();
        }
    };
}

#endif 