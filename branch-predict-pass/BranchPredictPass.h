#ifndef LLVM_TRANSFORMS_INSTRUMENTATION_BRANCH_PREDICT_PASS
#define LLVM_TRANSFORMS_INSTRUMENTATION_BRANCH_PREDICT_PASS

#include "llvm/IR/PassManager.h"
#include "llvm/IR/Function.h"
#include "llvm/IR/MDBuilder.h"
#include "llvm/Passes/PassBuilder.h"

namespace llvm {

class BranchPredictPass : public PassInfoMixin<BranchPredictPass> {
public:
    void assignBranchProb(BranchInst* branch, unsigned prob);
    PreservedAnalyses run(Function &F, FunctionAnalysisManager &AM);
};

}

#endif 