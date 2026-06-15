# NVIDIA L4T PyTorch base — JetPack 4.6.1, PyTorch 1.10, Python 3.6
FROM nvcr.io/nvidia/l4t-pytorch:r32.7.1-pth1.10-py3

WORKDIR /app

# Remove all kitware references (may be in sources.list or sources.list.d)
RUN grep -rl "kitware" /etc/apt/ | xargs sed -i '/kitware/d' 2>/dev/null || true

# System dependencies for OpenCV and Pillow
RUN apt-get -o Acquire::AllowInsecureRepositories=true update && \
    apt-get install -y --no-install-recommends --allow-unauthenticated \
    python3-opencv \
    libjpeg-dev \
    zlib1g-dev \
    libfreetype6-dev \
    && rm -rf /var/lib/apt/lists/*

# Upgrade pip so it can handle pyproject.toml-based packages
RUN pip3 install --upgrade pip setuptools wheel

# Install Python dependencies
RUN pip3 install pillow tqdm
RUN pip3 install git+https://github.com/yakhyo/uniface.git
RUN pip3 install onnxruntime

# Copy project files
COPY . /app/

CMD ["python3", "inference.py", "--model", "resnet18", "--weight", "weights/resnet18.pt", "--source", "0"]
