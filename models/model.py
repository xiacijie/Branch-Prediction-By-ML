import torch

class MyModule(torch.nn.Module):
    def __init__(self):
        super(MyModule, self).__init__()

    def forward(self):
        return 998

m = MyModule()
sm = torch.jit.script(m)
sm.save("./model.pt")