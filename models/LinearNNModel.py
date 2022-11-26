import torch  
import torch.nn as nn  
import torch.nn.functional as F


NUM_FEATURES = 22

DEVICE = torch.device('cuda' if torch.cuda.is_available() else 'cpu')

class LinearBranchPredictModel(nn.Module):  
    def __init__(self, num_features, device) -> None:  
        super().__init__()  
        self.layer1 = nn.Linear(num_features, 44, device=device)  
        self.layer2 = nn.Linear(44, 88, device=device)  
        self.layer3 = nn.Linear(88, 128, device=device)  
        self.layer4 = nn.Linear(128, 64, device=device)  
        self.layer5 = nn.Linear(64, 2, device=device)  
  
    def forward(self, x):  
        x = F.relu(self.layer1(x))  
        x = F.relu(self.layer2(x))  
        x = F.relu(self.layer3(x)) 
        x = F.relu(self.layer4(x)) 
        x = self.layer5(x)  
        x = torch.sigmoid(x)  
        return x  