#!/usr/bin/env bash
set -e
# Clone and checkout specified commits for each repo
# Genlayer JS:
git clone https://github.com/yeagerai/genlayer-js.git && cd genlayer-js && git checkout "$GENLAYER_JS_REF" && npm ci && npm run build && npm test && cd ..
# Studio:
git clone https://github.com/yeagerai/studio.git && cd studio && git checkout "$STUDIO_REF" && cp .env.example .env && docker compose up -d
# Install backend
pip install -r backend/requirements.txt && pytest backend/tests
# Install frontend
(cd frontend && npm ci && npm run build && npm run test:unit)
cd ..
git clone https://github.com/yeagerai/cli.git && cd cli && git checkout "$CLI_REF" && npm ci && npm run build && npm test && cd ..
git clone https://github.com/yeagerai/GenVM.git && cd GenVM && git checkout "$GENVM_REF" && cargo build && cargo test && cd ..
# (Optional) run cross-repo E2E tests, e.g., spin up services and run API/UI tests
echo "All component tests passed."
