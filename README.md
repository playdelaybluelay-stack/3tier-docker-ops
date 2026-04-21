# 3tier-docker-ops
VM 기반 온프레미스 3-Tier 아키텍처를 Docker Compose로 전환하고, Bash/Python으로 운영 자동화(헬스체크/리포트/장애 탐지)를 추가한 포트폴리오 프로젝트. Migrating a VM-based 3-tier architecture (VMware + Vagrant) to Docker Compose, with automated healthcheck/alerting in Bash &amp; Python.

>구축 기간: 2026-04-21 ~ (진행 중)

---

## 프로젝트 소개

메가존클라우드 MSP 솔루션 아키텍트 양성 과정에서 VM(VMware + Vagrant) 기반으로 구축한 온프레미스 3-Tier 아키텍처를, 수료 이후 Docker Compose로 재구현하는 프로젝트입니다. 단순 컨테이너화에 그치지 않고, 개인 프로젝트 당시 구현하지 못했던 **운영 모니터링 및 장애 탐지 자동화**를 Shell/Python 스크립트로 추가했습니다.

**핵심 차별점**
- **구축**이 아닌 **운영까지** 고려한 설계 — 헬스체크, 임계치 기반 알림
- **실제 장애 경험**을 점검 항목으로 반영 — DB Replication 오류(Slave_SQL_Running) 등
- **VM → Docker 전환 판단 근거**를 문서화 — NFS → volume, ACL → Docker network 등

## 왜 만들었나

개인 프로젝트 발표 당시 향후 개선점으로 명시했던 "모니터링 서버 미구성", "CI/CD 파이프라인 미구축"을 스스로 해결하기 위한 프로젝트입니다. 동일한 비즈니스 로직(헬프데스크 티켓 관리 시스템)을 유지하면서, 인프라 레이어를 전면 재설계했습니다.
