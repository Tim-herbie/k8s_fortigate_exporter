NAMESPACE := fortigate-exporter

FORTIGATE_EXPORTER_SECRET = $(shell printf "$(URL):\n    token: $(FORTIGATE_API_TOKEN)" | base64)

include fortigate.env

all: prep deployment servicemonitor

prep:
	kubectl create namespace $(NAMESPACE) --dry-run=client -o yaml | kubectl apply -f -

deployment:
	printf '%s' "$$(cat secret.yml | sed 's|{{FORTIGATE_EXPORTER_SECRET}}|$(FORTIGATE_EXPORTER_SECRET)|g')" | kubectl apply -f -
	kubectl -n $(NAMESPACE) apply -f deployment.yml
	kubectl -n $(NAMESPACE) apply -f service.yml

servicemonitor:
	printf '%s' "$$(cat serviceMonitor.yml | sed 's|{{URL}}|$(URL)|g')" | kubectl apply -f -

delete:
	@echo
	kubectl -n $(NAMESPACE) delete secret fortigate-credentials --ignore-not-found=true
	kubectl -n $(NAMESPACE) delete -f deployment.yml --ignore-not-found=true
	kubectl -n $(NAMESPACE) delete -f service.yml --ignore-not-found=true
	kubectl -n $(NAMESPACE) delete servicemonitor fortigate-exporter --ignore-not-found=true
	kubectl delete ns $(NAMESPACE)