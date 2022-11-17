#include "llvm/Transforms/Instrumentation/BranchPredictPass.h"

namespace llvm {

void BranchPredictPass::assignBranchProb(BranchInst* branch, unsigned prob) {
    assert(prob <= 100 && "Invalid prob");
    unsigned trueProb = prob;
    unsigned falseProb = 100 - prob;

    auto* branchProb = MDBuilder(branch->getContext()).createBranchWeights(trueProb, falseProb);
    branch->setMetadata(LLVMContext::MD_prof, branchProb);
}

PreservedAnalyses BranchPredictPass::run(Function &F, FunctionAnalysisManager &AM) {
    // currently we assign each branch a 50% 50% probabilities
    for (BasicBlock &BB : F) {
        BranchInst *BI = dyn_cast<BranchInst>(BB.getTerminator());
        if (BI && !BI->isUnconditional()) {
            assignBranchProb(BI, 50);
        }
    }
    return PreservedAnalyses::all();
}

}