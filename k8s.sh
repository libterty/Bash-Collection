#!/bin/bash

set -x

auto_start_k8s() {
    files=($(find -E . -type f -regex "^.*.yaml$"))
    for item in ${files[*]}; do
        kubectl apply -f $item
    done
}

write_srv_node_port_k8s() {

    fileName=$2
    port=$3
    targetPort=$4
    # $2 stands for the file name of your yaml
    touch "$fileName-srv.yaml"

    #3 stands for port
    #4 stands for targetPort
    echo "apiVersion: v1" >>"$fileName-srv.yaml"
    echo "kind: Service" >>"$fileName-srv.yaml"
    echo "metadata:" >>"$fileName-srv.yaml"
    echo "  name: $fileName-srv" >>"$fileName-srv.yaml"
    echo "spec:" >>"$fileName-srv.yaml"
    echo "  type: NodePort" >>"$fileName-srv.yaml"
    echo "  selector:" >>"$fileName-srv.yaml"
    echo "    app: $fileName" >>"$fileName-srv.yaml"
    echo "  ports:" >>"$fileName-srv.yaml"
    echo "    - name: $fileName" >>"$fileName-srv.yaml"
    echo "      protocol: TCP" >>"$fileName-srv.yaml"
    echo "      port: $port" >>"$fileName-srv.yaml"
    echo "      targetPort: $targetPort" >>"$fileName-srv.yaml"
}

write_depl_k8s() {
    fileName=$2
    replicas=$3
    user=$4
    # $2 stands for the file name of your yaml
    touch $fileName-depl.yaml

    #3 stands for port
    #4 stands for targetPort
    echo "apiVersion: v1" >>$fileName-depl.yaml
    echo "kind: Service" >>$fileName-depl.yaml
    echo "metadata:" >>$fileName-depl.yaml
    echo "  name: $fileName-depl" >>$fileName-depl.yaml
    echo "spec:" >>$fileName-depl.yaml
    echo "  replicas: $replicas" >>$fileName-depl.yaml
    echo "  selector:" >>$fileName-depl.yaml
    echo "    matchLabels:" >>$fileName-depl.yaml
    echo "      app: $fileName" >>$fileName-depl.yaml
    echo "  template:" >>$fileName-depl.yaml
    echo "    metadata:" >>$fileName-depl.yaml
    echo "      labels:" >>$fileName-depl.yaml
    echo "      app: $fileName" >>$fileName-depl.yaml
    echo "    spec:" >>$fileName-depl.yaml
    echo "      containers:" >>$fileName-depl.yaml
    echo "        - name: $fileName" >>$fileName-depl.yaml
    echo "          image: $user/$fileName:latest" >>$fileName-depl.yaml
    echo "          resources:" >>$fileName-depl.yaml
    echo "            limits:" >>$fileName-depl.yaml
    echo "              memory: "128Mi"" >>$fileName-depl.yaml
    echo "              cpu: "500m"" >>$fileName-depl.yaml
}

main() {
    if [ $1 = start ]; then
        auto_start_k8s
    elif [ $1 = srv ]; then
        write_srv_node_port_k8s $1 $2 $3 $4
    elif [ $1 = depl ]; then
        write_depl_k8s $1 $2 $3 $4
    else
        echo Fail with Wrong arg
    fi
}

main $1 $2 $3 $4
