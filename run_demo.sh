#!/usr/bin/env bash
set -e

python scripts/generate_data.py
python scripts/run_pipeline.py
python scripts/validate_data.py
python streaming/producer_mock.py
python streaming/window_aggregation_mock.py
streamlit run dashboard/app.py
