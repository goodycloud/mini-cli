FROM docker.io/library/gcc:13

WORKDIR /app

# C 소스 코드 복사
COPY src/mini.c .

# 컴파일
RUN gcc mini.c -o mini && \
    rm mini.c

# 컨테이너 시작 시 실행할 명령
CMD ["./mini", "from", "docker"]
