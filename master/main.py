from kubernetes import client, config
from flask import Flask
import time

# Configs can be set in Configuration class directly or using helper utility
config.load_kube_config()

app = Flask(__name__)
@app.route("/")
def hello():
	v1 = client.CoreV1Api()
	print("Listing pods with their IPs:")
	ret = v1.list_pod_for_all_namespaces(watch=False)
	for i in ret.items:
		print("%s\t%s\t%s" % (i.status.pod_ip, i.metadata.namespace, i.metadata.name))
	time.sleep(120);

if __name__ == "__main__":
	app.run(host='0.0.0.0')
