FROM python:3.8-slim-buster

# Copy required files to the container
COPY ./bmi.py /tmp/bmi.py
COPY ./requirements.txt /tmp/requirements.txt
COPY ./bmi.gif /tmp/bmi.gif
COPY ./bmi.mp4 /tmp/bmi.mp4
COPY ./bmi.jpg /tmp/bmi.jpg
COPY ./fat_man.jpg /tmp/fat_man.jpg
COPY ./fat_woman.jpg /tmp/fat_woman.jpg
COPY ./healthy_boy.jpg /tmp/healthy_boy.jpg
COPY ./healthy_woman.jpg /tmp/healthy_woman.jpg
COPY ./thin_woman.jpg /tmp/thin_woman.jpg
COPY ./thin_man.jpg /tmp/thin_man.jpg

# Install linux dependemcies
RUN apt-get update \
    && apt-get install nano git build-essential libglib2.0-0 libsm6 libxext6 libxrender-dev -y \
    && apt-get install libpangocairo-1.0-0 -y \
    && apt-get install libcairo2-dev libjpeg-dev libgif-dev -y\
    && apt-get install libsndfile1 -y\
    && apt install libicu-dev python3-icu pkg-config -y\
    && apt install python3-dev libpq-dev -y

# Install python dependencies
RUN pip install --no-cache-dir --upgrade pip setuptools wheel \
    && pip install --no-cache-dir -r /tmp/requirements.txt

# Clean caches
RUN pip cache purge \
    && apt-get clean \
    && apt-get autoremove -y \
    && rm -rf /var/lib/apt/lists/* \
    && rm -rf /root/.cache/pip

# Expose port 8051
EXPOSE 8051

# Run the application
ENTRYPOINT [ "streamlit", "run", "/tmp/bmi.py" ]