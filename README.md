# 📦 Chimera CI – A DevSecOps Pipeline in a Box

[![GitHub Actions](https://img.shields.io/github/actions/workflow/status/Sceptr3sec/chimera-ci/pipeline.yml?branch=main\&label=CI%2FCD)](https://github.com/Sceptr3sec/chimera-ci/actions)
[![Docker Pulls](https://img.shields.io/badge/GHCR-pull%20image-blue)](https://github.com/users/Sceptr3sec/packages/container/package/chimera-ci)
[![License](https://img.shields.io/github/license/Sceptr3sec/chimera-ci?color=brightgreen)](LICENSE)

---

## 🚀 Overview

**Chimera CI** is a **plug-and-play DevSecOps container** for GitHub Actions.
It bundles industry-standard security tools into a single container image, so any project can drop in a workflow and instantly run:

* ✅ **SAST**: [Semgrep](https://semgrep.dev/)
* ✅ **SCA / Container Scanning**: [Trivy](https://aquasecurity.github.io/trivy/)
* ✅ **IaC Scanning**: [Checkov](https://www.checkov.io/)
* ✅ **Secrets Detection**: [Gitleaks](https://github.com/gitleaks/gitleaks)
* ⚡ Future: DAST via [OWASP ZAP](https://www.zaproxy.org/)

This project is designed as a **“pipeline in a box”** → portable, reusable, and easy to maintain.

---

## 🐳 Usage

### 1. Pull the Container

```bash
docker pull ghcr.io/sceptr3sec/chimera-ci:latest
```

### 2. Run Locally

```bash
docker run --rm -v $(pwd):/app ghcr.io/sceptr3sec/chimera-ci:latest semgrep --config=auto /app
```

### 3. Use in GitHub Actions

Add `.github/workflows/pipeline.yml`:

```yaml
name: DevSecOps Pipeline

on: [push, pull_request]

jobs:
  security-scan:
    runs-on: ubuntu-latest
    container:
      image: ghcr.io/sceptr3sec/chimera-ci:latest
    steps:
      - uses: actions/checkout@v4

      - name: Run Semgrep
        run: semgrep --config=auto .

      - name: Run Trivy
        run: trivy fs --exit-code 1 --severity HIGH,CRITICAL .

      - name: Run Checkov
        run: checkov -d .

      - name: Run Gitleaks
        run: gitleaks detect --source . --no-git -v
```

---

## 📊 Reports

Each tool outputs results directly to the GitHub Actions logs.
Future versions will export SARIF to integrate with the **GitHub Security tab**.

---

## 🛠️ Development

### Build

```bash
docker build -t ghcr.io/sceptr3sec/chimera-ci:latest .
```

### Push

```bash
docker push ghcr.io/sceptr3sec/chimera-ci:latest
```

---

## 📅 Roadmap

* [ ] Add SARIF report export
* [ ] Weekly automated image rebuilds
* [ ] Add compliance mappings (NIST/SOC2 baseline)

---

## 🤝 Contributing

PRs are welcome! For major changes, open an issue first to discuss.

---

## 📜 License

MIT © [Sceptr3sec](https://github.com/Sceptr3sec)

---

Do you want me to also generate a **diagram (Mermaid or SVG)** of the pipeline flow (code → scans → reports) so you can drop it into the README for visual impact?

