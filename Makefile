URL = https://repology.org/api/v1/project/cloud-init

update:
	# docker run quay.io/watchdogpolska/alpine-curl curl -L -s $(URL) > content.json
	docker run quay.io/watchdogpolska/alpine-curl curl -L -s $(URL)  | docker run -i stedolan/jq 'sort_by(.repo)' > content.json
	docker run quay.io/watchdogpolska/alpine-curl curl -L -s $(URL)  | docker run -i stedolan/jq 'sort_by(.repo)' | docker run -i quay.io/watchdogpolska/yq -y '.' > content.yaml

git_setup:
	git config user.email "rbx-openapi-archive@github.com"
	git config user.name "Bot"
	
commit:
	git add * && git commit -m "$$(date +"Update %d-%m-%d %H:%M")" || exit 0;