import matplotlib.pyplot as plt
import numpy as np

benchmarks = ["libpng", "lua", "oggvorbis", "sela", "sqlite", "tscp", "z3"]

models = ["Base", "MLP-Clas", "MLP-Regr", "SVM-Regr", "AdaBst-Regr", "RanFst-Regr"]

runtime = {
    "libpng" : [4.80633083118,5.17440450318,4.83051374318,4.72344541818,4.80337389318,4.72564215518],
    "lua": [4.54698774678,4.49363972778,4.18907122878,4.17626519078,4.18892928578,4.27114521678],
    "oggvorbis":[2.06458654902,1.9900354350199998,2.0049331490199997,2.0633438860199997,2.02121482902,2.0127877980199997],
    "sela":[0.013817019420000002,0.015491758420000001,0.014066249420000001,0.014277708420000002,0.013153851420000001,0.013962164420000001],
    "sqlite":[4.78941013648,4.516277189479999,4.553916099479999,4.4921827284799996,4.60317138748,4.53910650948],
    "tscp":[1.10089313906,1.07574924806,1.06604562706,1.06355632206,1.06843728906,1.07353561206],
    "z3":[0.29553894868,0.30764993368,0.29545137868,0.29108933868000003,0.30238296568,0.29929614268]
}

normalized_run_time = {}
for bench in runtime.keys():
    times = runtime[bench]
    base_time = times[0]
    normalized_run_time[bench] = []
    for i in range(len(times)):
        time = times[i]
        s = time/base_time
        normalized_run_time[bench].append(s)

def plot_normalized_runtime(bench):
    plt.clf()
    
    y_pos = np.arange(len(models))
    plt.bar(y_pos, normalized_run_time[bench], align='center', alpha=0.5)
    plt.xticks(y_pos, models, fontsize=9)
    xlocs, xlabs = plt.xticks()
    for i, v in enumerate(normalized_run_time[bench]):
        plt.text(xlocs[i] - 0.25, v+0.002, str(round(v,3)))

    plt.ylabel('Normalized runtime')
    plt.title(bench)

    plt.savefig(bench +".png")

for bench in benchmarks:
    plot_normalized_runtime(bench)

average_speed_up = []
for i, m in enumerate(models):
    if i == 0:
        continue

    s = 0
    for bench in normalized_run_time.keys():
        n_times = normalized_run_time[bench]
        s += 1 - n_times[i]
    average_speed_up.append(s / len(benchmarks))

plt.clf()

y_pos = np.arange(len(models[1:]))
plt.bar(y_pos, average_speed_up, align='center', alpha=0.5)
plt.xticks(y_pos, models[1:], fontsize=9)
xlocs, xlabs = plt.xticks()
for i, v in enumerate(average_speed_up):
    plt.text(xlocs[i] - 0.25, v+0.001, str(round(v,3)))

plt.ylabel('Speed up')
plt.title('Average speedup of each model')

plt.savefig("average_speedup.png")
