
# 🛠️ Mini CLI Tool Project

이 프로젝트는 리눅스 환경에서 간단한 C 기반 CLI 프로그램을 작성하고,  
이를 Docker 이미지로 빌드한 후 GitHub로 버전 관리를 수행하는 실습용 미니 프로젝트입니다.  

프로그래밍 자체는 단순하지만,  
**오픈소스 개발 흐름(코드 작성 → Linux 실행 → Docker 패키징 → Git 및 GitHub 배포)** 을 직접 경험하는 것이 핵심 목표입니다.



## 📁 1. 프로젝트 구조

```text
mini-cli/
 ├─ src/
 │   └─ mini.c
 ├─ Dockerfile
 ├─ README.md
 ├─ LICENSE
 └─ docs/
     └─ images/
         ├─ linux_run.png
         ├─ docker_run.png
         └─ git-log.png

---
```
## 🖥️ 2. Mini CLI 프로그램 소개

프로그램은 전달된 인자를 출력하는 간단한 CLI 도구입니다.

### `src/mini.c`

```c
#include <stdio.h>

int main(int argc, char *argv[]) {
    printf("Hello from Mini CLI Tool!\n");
    printf("You passed %d arguments.\n", argc - 1);

    for (int i = 1; i < argc; i++) {
        printf("arg %d: %s\n", i, argv[i]);
    }

    return 0;
}
```

---

## 🐧 3. Linux 환경에서 빌드 및 실행 (WSL 사용)

이 실습은 Windows 환경의 WSL2(Ubuntu)를 사용하여 진행했습니다.

### 3-1. 패키지 업데이트 및 gcc 설치

```bash
sudo apt update
sudo apt install -y gcc
```

### 3-2. 컴파일

```bash
cd ~/mini-cli
gcc src/mini.c -o mini
```

### 3-3. 실행 예시

```bash
./mini
./mini hello world
```

### 3-4. 실행 결과 캡처

![Linux 실행 화면](./docs/images/linux_run.png)

---

## 🐳 4. Docker 이미지 빌드 및 실행

WSL 환경에서 `docker` 명령은 `podman`을 에뮬레이션하여 실행되었습니다.
컨테이너 내부에서 동일한 CLI 프로그램을 실행하도록 Dockerfile을 구성했습니다.

### 4-1. Dockerfile

```Dockerfile
FROM docker.io/library/gcc:13

WORKDIR /app

# C 소스 코드 복사
COPY src/mini.c .

# 컴파일
RUN gcc mini.c -o mini && \
    rm mini.c

# 컨테이너 시작 시 실행할 명령
CMD ["./mini", "from", "docker"]
```

---

### 4-2. Docker 이미지 빌드

```bash
cd ~/mini-cli
docker build -t localhost/mini-cli:latest .
```

### 4-3. Docker 컨테이너 실행

```bash
docker run --rm localhost/mini-cli:latest
```

### 4-4. 실행 결과 캡처

![Docker 실행 화면](./docs/images/docker_run.png)

---

## 🌿 5. Git Workflow (커밋/브랜치 관리)

과제 요구사항에 따라 다음과 같은 Git 흐름을 사용했습니다.

### ✔ 체크리스트

* [x] Commit 최소 5회 이상
* [x] Branch 1개 생성
* [x] Branch → main Merge 수행
* [x] 의미 있는 Commit 메시지 사용

### ✔ Git 작업 요약

```bash
git init
git add README.md LICENSE
git commit -m "Add initial project structure and documentation"

git add src/mini.c
git commit -m "Add mini CLI tool C source code"

git add Dockerfile
git commit -m "Add Dockerfile for building CLI tool"

git checkout -b feature/docs
git add README.md
git commit -m "Improve README with Linux and Docker execution steps"

git add docs/images/
git commit -m "Add screenshots for Linux and Docker execution"

git checkout main
git merge feature/docs
```

![git log 화면](./docs/images/git-log.png)
---

## 📄 6. 라이선스 (LICENSE)

본 프로젝트는 **MIT License**를 적용합니다.

`LICENSE` 파일에 다음과 같은 내용을 포함했습니다:

```text
MIT License

Copyright (c) 2025 정현준

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

(이하 생략 — LICENSE 파일에 전체 전문 포함)
```

---

## 📝 7. 고찰

* WSL 기반 Linux 환경에서 gcc 설치부터 컴파일, 실행까지의 전체 흐름을 직접 경험할 수 있었다.
* Docker가 podman을 에뮬레이션하는 환경이라, 이미지 빌드 시 short-name 관련 오류가 발생했으나
  `docker.io/library/gcc:13` 와 같이 레지스트리 전체 경로를 지정하여 문제를 해결했다.
* Git에서 브랜치를 생성하고 merge하는 과정을 직접 수행하며,
  협업 시 사용되는 기본적인 Git workflow를 이해할 수 있었다.
* 추후에는 GitHub Actions 등을 활용하여 Docker 이미지 빌드를 자동화해보는 것도 목표로 삼을 수 있을 것 같다.

---

## 📚 8. 참고 자료

* [https://docs.docker.com/](https://docs.docker.com/)
* [https://gcc.gnu.org/](https://gcc.gnu.org/)
* [https://learn.microsoft.com/windows/wsl/](https://learn.microsoft.com/windows/wsl/)
* [https://choosealicense.com/](https://choosealicense.com/)
