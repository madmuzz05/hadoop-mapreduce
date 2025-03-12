# Word Count MapReduce

This project contains a MapReduce implementation for counting words using Hadoop Streaming.

## Files

- `mapper.py`: Mapper script
- `reducer.py`: Reducer script
- `output.txt`: Output of the MapReduce job

## How to Run

1. Build the Docker image:
    ```sh
    docker compose build && docker compose up -d
    ```

2. Run the Docker container:
    ```sh
    docker run -it hadoop-hadoop
    ```

3. Download the input file:
    ```sh
    wget -O /opt/uud45.txt https://raw.githubusercontent.com/ayyoubmaul/hadoop-docker/refs/heads/main/data/uud45.txt
    ```

4. Execute the MapReduce job using Hadoop Streaming:
    ```sh
    hadoop jar $HADOOP_HOME/share/hadoop/tools/lib/hadoop-streaming-$HADOOP_VERSION.jar \
        -input /opt/uud45.txt \
        -output /opt/output \
        -mapper /opt/mapper.py \
        -reducer /opt/reducer.py \
        -file /opt/mapper.py \
        -file /opt/reducer.py
    ```

5. Save the output to a local file:
    ```sh
    cat /opt/output/part-00000 > /opt/output.txt
    ```

6. Push the code and output to GitHub:
    ```sh
    cd /opt
    git init
    git remote add origin https://github.com/yourusername/yourrepository.git
    git add .
    git commit -m "Add output txt from docker"
    git push -u origin yourbranch
    ```

7. Exit the container:
    ```sh
    exit
    ```