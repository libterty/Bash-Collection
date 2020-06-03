#!/bin/bash

set -x

auto_start_k8s() {
  files=($(find -E . -type f -regex "^.*.yaml$"))
  for item in ${files[*]}; do
    kubectl apply -f $item
  done
}

write_srv_node_port_k8s() {
  # $2 stands for the file name of your yaml
  touch $2-srv.yaml

  #3 stands for port
  #4 stands for targetPort
  echo "apiVersion: v1" >>$2-srv.yaml
  echo "kind: Service" >>$2-srv.yaml
  echo "metadata:" >>$2-srv.yaml
  echo "  name: $2-srv" >>$2-srv.yaml
  echo "spec:" >>$2-srv.yaml
  echo "  type: NodePort" >>$2-srv.yaml
  echo "  selector:" >>$2-srv.yaml
  echo "    app: $2" >>$2-srv.yaml
  echo "  ports:" >>$2-srv.yaml
  echo "    - name: $2" >>$2-srv.yaml
  echo "      protocol: TCP" >>$2-srv.yaml
  echo "      port: $3" >>$2-srv.yaml
  echo "      targetPort: $4" >>$2-srv.yaml
}

write_depl_k8s() {
  # $2 stands for the file name of your yaml
  touch $2-depl.yaml

  #3 stands for port
  #4 stands for targetPort
  echo "apiVersion: v1" >>$2-depl.yaml
  echo "kind: Service" >>$2-depl.yaml
  echo "metadata:" >>$2-depl.yaml
  echo "  name: $2-depl" >>$2-depl.yaml
  echo "spec:" >>$2-depl.yaml
  echo "  replicas: $3" >>$2-depl.yaml
  echo "  selector:" >>$2-depl.yaml
  echo "    matchLabels:" >>$2-depl.yaml
  echo "      app: $2" >>$2-depl.yaml
  echo "  template:" >>$2-depl.yaml
  echo "    metadata:" >>$2-depl.yaml
  echo "      labels:" >>$2-depl.yaml
  echo "      app: $2" >>$2-depl.yaml
  echo "    spec:" >>$2-depl.yaml
  echo "      containers:" >>$2-depl.yaml
  echo "        - name: $2" >>$2-depl.yaml
  echo "          image: $4/$2:latest" >>$2-depl.yaml
  echo "          resources:" >>$2-depl.yaml
  echo "            limits:" >>$2-depl.yaml
  echo "              memory: "128Mi"" >>$2-depl.yaml
  echo "              cpu: "500m"" >>$2-depl.yaml
}

main() {
  if [ "$1" = "start" ]; then
    auto_start_k8s
  elif [ "$1" = "srv" ]; then
    write_srv_node_port_k8s
  elif [ "$1" = "depl" ]; then
    write_depl_k8s
  fi
}

main
