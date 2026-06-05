# University Data Platform MVP

This repository contains a defense-ready MVP for a domain-oriented university data platform.

The project has two modes:

1. **Local demo mode**: lightweight, reproducible on weak laptops.
2. **Target architecture mode**: cloud/IaC and production-style components represented as code and configuration.

## Domains

| Domain | Purpose |
|---|---|
| `academic_performance` | Grades, LMS activity, attendance, student risk features |
| `campus_infrastructure` | Room occupancy and campus events |
| `student_engagement` | LMS engagement and student activity |

## Architecture

```text
CSV / LMS API mock
        -> Bronze Parquet
        -> Data Quality checks
        -> Silver Parquet
        -> Gold features / KPIs
        -> Streamlit dashboard

Kafka/Flink/ClickHouse/Grafana/Cube.js/Feast are represented as target architecture artifacts.
```

## Quick Start

Create virtual environment:

```bash
python -m venv .venv
```

Activate it.

Windows:

```bash
.venv\Scripts\activate
```

macOS/Linux:

```bash
source .venv/bin/activate
```

Install dependencies:

```bash
pip install -r requirements.txt
```

Run the batch pipeline:

```bash
python scripts/generate_data.py
python scripts/run_pipeline.py
python scripts/validate_data.py
```

Run streaming mock:

```bash
python streaming/producer_mock.py
python streaming/window_aggregation_mock.py
```

Run dashboard:

```bash
streamlit run dashboard/app.py
```

## What works live

- Data generation.
- Ingestion into Bronze.
- Cleaning into Silver.
- Feature and KPI creation in Gold.
- Data quality report.
- Mock streaming aggregation.
- Embedded analytics dashboard in Streamlit.

## What is represented as target architecture

| Requirement | Artifact |
|---|---|
| Terraform cloud infrastructure | `infra/terraform/` |
| Object Storage | `infra/terraform/main.tf`, local `data/bronze` |
| Managed Kafka | `infra/terraform/main.tf`, `streaming/producer.py` |
| Airflow | `dags/ingest_lms_to_s3.py` |
| Great Expectations | `great_expectations/expectations/` and `scripts/validate_data.py` |
| Lakehouse Bronze/Silver/Gold | `data/bronze`, `data/silver`, `data/gold` |
| Feature Store | `feature_store/` |
| Flink streaming job | `streaming/flink_window.sql` |
| ClickHouse | `streaming/clickhouse_schema.sql` |
| Grafana realtime dashboard | represented by Streamlit realtime tab |
| Cube.js Semantic Layer | `semantic_layer/StudentPerformance.js` |
| CI/CD | `.gitlab-ci.yml` |
| ADR and Data Products | `docs/` |

## Defense Story

Use this explanation:

> The project is implemented as a local demonstration stand and a target cloud architecture.
> The local mode reproduces the full data path from sources to dashboard on limited hardware.
> The target architecture describes how the same logic is deployed with Terraform, Airflow, Kafka,
> Flink, ClickHouse, Feast, Cube.js and GitLab CI/CD.

## Suggested Demo Flow

1. Show `README.md` and architecture.
2. Run:
   ```bash
   python scripts/generate_data.py
   python scripts/run_pipeline.py
   python scripts/validate_data.py
   ```
3. Show `data/bronze`, `data/silver`, `data/gold`.
4. Run:
   ```bash
   python streaming/producer_mock.py
   python streaming/window_aggregation_mock.py
   ```
5. Open:
   ```bash
   streamlit run dashboard/app.py
   ```
6. Show Terraform, Airflow DAG, Flink SQL, Feast config, Cube.js schema, CI/CD pipeline.
7. Explain that heavy services are target components and the local mode is used for stable defense reproduction.
