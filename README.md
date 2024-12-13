# DiskANN

[![DiskANN Main](https://github.com/microsoft/DiskANN/actions/workflows/push-test.yml/badge.svg?branch=main)](https://github.com/microsoft/DiskANN/actions/workflows/push-test.yml)
[![PyPI version](https://img.shields.io/pypi/v/diskannpy.svg)](https://pypi.org/project/diskannpy/)
[![Downloads shield](https://pepy.tech/badge/diskannpy)](https://pepy.tech/project/diskannpy)
[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)

[![DiskANN Paper](https://img.shields.io/badge/Paper-NeurIPS%3A_DiskANN-blue)](https://papers.nips.cc/paper/9527-rand-nsg-fast-accurate-billion-point-nearest-neighbor-search-on-a-single-node.pdf)
[![DiskANN Paper](https://img.shields.io/badge/Paper-Arxiv%3A_Fresh--DiskANN-blue)](https://arxiv.org/abs/2105.09613)
[![DiskANN Paper](https://img.shields.io/badge/Paper-Filtered--DiskANN-blue)](https://harsha-simhadri.org/pubs/Filtered-DiskANN23.pdf)


DiskANN is a suite of scalable, accurate and cost-effective approximate nearest neighbor search algorithms for large-scale vector search that support real-time changes and simple filters.
This code is based on ideas from the [DiskANN](https://papers.nips.cc/paper/9527-rand-nsg-fast-accurate-billion-point-nearest-neighbor-search-on-a-single-node.pdf), [Fresh-DiskANN](https://arxiv.org/abs/2105.09613) and the [Filtered-DiskANN](https://harsha-simhadri.org/pubs/Filtered-DiskANN23.pdf) papers with further improvements. 
This code forked off from [code for NSG](https://github.com/ZJULearning/nsg) algorithm.

This project has adopted the [Microsoft Open Source Code of Conduct](https://opensource.microsoft.com/codeofconduct/).
For more information see the [Code of Conduct FAQ](https://opensource.microsoft.com/codeofconduct/faq/) or
contact [opencode@microsoft.com](mailto:opencode@microsoft.com) with any additional questions or comments.

See [guidelines](CONTRIBUTING.md) for contributing to this project.

## Linux build:

Install the following packages through apt-get

```bash
sudo apt install make cmake g++ libaio-dev libgoogle-perftools-dev clang-format libboost-all-dev
```

### Install Intel MKL
#### Ubuntu 20.04 or newer
```bash
sudo apt install libmkl-full-dev
```

#### Earlier versions of Ubuntu
Install Intel MKL either by downloading the [oneAPI MKL installer](https://www.intel.com/content/www/us/en/developer/tools/oneapi/onemkl.html) or using [apt](https://software.intel.com/en-us/articles/installing-intel-free-libs-and-python-apt-repo) (we tested with build 2019.4-070 and 2022.1.2.146).

```
# OneAPI MKL Installer
wget https://registrationcenter-download.intel.com/akdlm/irc_nas/18487/l_BaseKit_p_2022.1.2.146.sh
sudo sh l_BaseKit_p_2022.1.2.146.sh -a --components intel.oneapi.lin.mkl.devel --action install --eula accept -s
```

### Build
```bash
mkdir build && cd build && cmake -DCMAKE_BUILD_TYPE=Release .. && make -j 
```

## Windows build:

The Windows version has been tested with Enterprise editions of Visual Studio 2022, 2019 and 2017. It should work with the Community and Professional editions as well without any changes. 

**Prerequisites:**

* CMake 3.15+ (available in VisualStudio 2019+ or from https://cmake.org)
* NuGet.exe (install from https://www.nuget.org/downloads)
    * The build script will use NuGet to get MKL, OpenMP and Boost packages.
* DiskANN git repository checked out together with submodules. To check out submodules after git clone:
```
git submodule init
git submodule update
```

* Environment variables: 
    * [optional] If you would like to override the Boost library listed in windows/packages.config.in, set BOOST_ROOT to your Boost folder.

**Build steps:**
* Open the "x64 Native Tools Command Prompt for VS 2019" (or corresponding version) and change to DiskANN folder
* Create a "build" directory inside it
* Change to the "build" directory and run
```
cmake ..
```
OR for Visual Studio 2017 and earlier:
```
<full-path-to-installed-cmake>\cmake ..
```
**This will create a diskann.sln solution**. Now you can:

- Open it from VisualStudio and build either Release or Debug configuration.
- `<full-path-to-installed-cmake>\cmake --build build`
- Use MSBuild:
```
msbuild.exe diskann.sln /m /nologo /t:Build /p:Configuration="Release" /property:Platform="x64"
```

* This will also build gperftools submodule for libtcmalloc_minimal dependency.
* Generated binaries are stored in the x64/Release or x64/Debug directories.

## Usage:

Please see the following pages on using the compiled code:

- [Commandline interface for building and search SSD based indices](workflows/SSD_index.md)  
- [Commandline interface for building and search in memory indices](workflows/in_memory_index.md) 
- [Commandline examples for using in-memory streaming indices](workflows/dynamic_index.md)
- [Commandline interface for building and search in memory indices with label data and filters](workflows/filtered_in_memory.md)
- [Commandline interface for building and search SSD based indices with label data and filters](workflows/filtered_ssd_index.md)
- [diskannpy - DiskANN as a python extension module](python/README.md)

Please cite this software in your work as:

```
@misc{diskann-github,
   author = {Simhadri, Harsha Vardhan and Krishnaswamy, Ravishankar and Srinivasa, Gopal and Subramanya, Suhas Jayaram and Antonijevic, Andrija and Pryce, Dax and Kaczynski, David and Williams, Shane and Gollapudi, Siddarth and Sivashankar, Varun and Karia, Neel and Singh, Aditi and Jaiswal, Shikhar and Mahapatro, Neelam and Adams, Philip and Tower, Bryan and Patel, Yash}},
   title = {{DiskANN: Graph-structured Indices for Scalable, Fast, Fresh and Filtered Approximate Nearest Neighbor Search}},
   url = {https://github.com/Microsoft/DiskANN},
   version = {0.6.1},
   year = {2023}
}
```


# DiskANN 实验指南



## 前置条件

1. Linux系统：Ubuntu 20.04 or newer



## DiskANN的下载与安装

### 下载

参考资料：[microsoft/DiskANN: Graph-structured Indices for Scalable, Fast, Fresh and Filtered Approximate Nearest Neighbor Search](https://github.com/microsoft/DiskANN)

首先使用apt安装DiskANN所需要的第三方包：

```bash
sudo apt install make cmake g++ libaio-dev libgoogle-perftools-dev clang-format libboost-all-dev
sudo apt install libmkl-full-dev
```

使用git克隆DiskANN库

```bash
git clone https://github.com/xrj1014/DiskANN.git
```

如果还没有git，可以运行`sudo apt install git`进行安装。

### 构建

进入DiskANN目录，执行以下命令：

```bash
mkdir build # 创建build目录，编译构建的所有生成的东西都会在这个build里面
cd build 
cmake -DCMAKE_BUILD_TYPE=Release .. # 执行cmake 进行make的前置工作
make -j # 编译DiskANN代码并生成各种可执行文件
```

如果命令执行成功，DiskANN程序就已经构建完成。实际使用的程序均在`DiskANN/build/apps`目录中。

## 使用DiskANN运行测试例子

### sift1M

参考资料：[DiskANN/workflows/SSD_index.md at main · microsoft/DiskANN](https://github.com/microsoft/DiskANN/blob/main/workflows/SSD_index.md)

（这里我们的命令略有不同，主要是因为文件放置的目录不同~）

#### 数据集的下载与前置准备

首先我们在DiskANN目录下创建一个data目录，里面存放数据集以及所有程序运行中生成的临时文件。

确保自己在DiskANN目录下，然后

```bash
mkdir -p data #创建data目录用于存放数据集
cd data #进入data目录
```

把sift1m数据集下载到当前目录下，并且解压缩。

```bash
wget ftp://ftp.irisa.fr/local/texmex/corpus/sift.tar.gz # “wget 文件链接” 即可下载对应文件
tar -xf sift.tar.gz # 解压缩，此时会多一个sift目录
```

sift目录长成这个样子：

```bash
sift
├── sift_base.fvecs
├── sift_groundtruth.ivecs
├── sift_learn.fvecs
└── sift_query.fvecs
```

它包含了四个文件，从文件名中可以看出每个文件的用途。其中`.ivecs`和`.fvecs`是数据集的格式，f表示`float`类型，i表示`int`类型。可以看出，sift1m数据集中的base数据类型是`float`。Groundtruth文件中存放的是索引，所以是整型。在接下来的过程中，我们只需要用到learn和query文件。

接下来，我们进行数据的预处理。DiskANN的程序接受的输入是binary文件，因此我们首先需要将`fvecs`文件转化为二进制文件。这一步骤可以利用DiskANN中自带的`fvecs_to_bin`程序进行。用法为：`[fvecs_to_bin]的位置 数据类型 源fvecs文件位置 目标fbin文件位置`。比如，首先`进入DiskANN主目录`（如果你在子目录下，可用`cd ..`到达上一层目录），然后执行

```bash
./build/apps/utils/fvecs_to_bin float data/sift/sift_learn.fvecs data/sift/sift_learn.fbin
./build/apps/utils/fvecs_to_bin float data/sift/sift_query.fvecs data/sift/sift_query.fbin
```

然后我们准备groundtruth文件，存放query对应最近邻的正确答案，这样才能在后面测试召回率。虽然数据集中已经给定groundtruth，但DiskANN也提供了`compute_groundtruth`程序用于计算groundtruth文件。执行以下命令（注意，这是一行），基于`learn`数据，计算`query`中的每个点的100个最近邻，存放到新文件`data/sift/sift_query_learn_gt100`中。

```bash
./build/apps/utils/compute_groundtruth  --data_type float --dist_fn l2 --base_file data/sift/sift_learn.fbin --query_file  data/sift/sift_query.fbin --gt_file data/sift/sift_query_learn_gt100 --K 100
```

其中的选项：

* `--data_type`：类型，这里是float
* `--dist_fn`：距离的定义方式，这里是l2
* `--base_file`：用于搜索最近邻的数据集，这里是learn文件
* `--query_file`：query，搜索这些点的最近邻，这里是query文件
* `--gt_file`：生成GT文件的位置
* `--K`：对于每个query，生成K个最近邻，这里是100

【请注意！！！】这里的groundtruth是基于learn数据生成的，而非base。而后面的build index过程同样也是基于learn数据集。这两个大小没有差别。也就是说，base数据集似乎从头到尾就没有用上。

接下来就可以正式进行build and search。首先是build index：（这是一行）

```bash
./build/apps/build_disk_index --data_type float --dist_fn l2 --data_path data/sift/sift_learn.fbin --index_path_prefix data/sift/disk_index_sift_learn_R32_L50_A1.2 -R 32 -L50 -B 0.003 -M 1 -A 1.2
```

选项：

* `data_type`：同上
* `dist_fn`：同上
* `data_path`：用于建立索引的数据文件
* `index_path_prefix`：生成索引文件的前缀
* `R`：max degree
* `L`：搜索列表
* `B`：search时用到的最大内存（单位为GB）
* `M`：build时用到的最大内存
* `A`：alpha

请注意，这里是alpha是新增的参数，源代码中没有。详细的参数说明可见[DiskANN/workflows/SSD_index.md at main · xrj1014/DiskANN](https://github.com/xrj1014/DiskANN/blob/main/workflows/SSD_index.md#to-generate-an-ssd-friendly-index-use-the-appsbuild_disk_index-program)。

建立完索引之后，就可以进行搜索测试。接下来这条命令，是使用生成的index文件（以`data/sift/disk_index_sift_learn_R32_L50_A1.2`为前缀），分别在search list 为 10，20，30，40，50，100的情形下测试K-recall@K（这里K=10），并将结果存至以`data/sift/res`为前缀的文件中。详细参数说明见[DiskANN/workflows/SSD_index.md at main · xrj1014/DiskANN](https://github.com/xrj1014/DiskANN/blob/main/workflows/SSD_index.md#to-search-the-ssd-index-use-the-appssearch_disk_index-program)。

```bash
./build/apps/search_disk_index  --data_type float --dist_fn l2 --index_path_prefix data/sift/disk_index_sift_learn_R32_L50_A1.2 --query_file data/sift/sift_query.fbin  --gt_file data/sift/sift_query_learn_gt100 -K 10 -L 10 20 30 40 50 100 --result_path data/sift/res --num_nodes_to_cache 10000
```



### sift1B

待更新
