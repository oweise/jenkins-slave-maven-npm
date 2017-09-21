kisaro247/maven-npm-jenkins-slave: Jenkins Slave Image für Maven and NPM (and Docker)
=====================================================================================

An Image to be used to construct Jenkins Slaves via the Kubernetes Plugin. It provides:

- mvn 3.5.0
- NodeJS 6
- The most recent docker CE upon time of building

This was originally intended to be used with OpenShift's integrated Jenkins (and uses its base image for Jenkins slaves openshift/jenkins-slave-base-centos7) but I don't see anything that actually binds it to that platform.

To use it install the [Kubernetes Plugin](https://github.com/jenkinsci/kubernetes-plugin) to Jenkins (if not already there) and then do something like the following in your pipeline:

```
podTemplate(label: 'pimped-jenkins-slave', cloud: 'openshift', containers: [
    containerTemplate(name: 'jnlp', image: 'kisaro247/maven-npm-jenkins-slave:1.4', args: '${computer.jnlpmac} ${computer.name}')
  ]) {
    node('pimped-jenkins-slave') {
                    ... this runs on your image ..
    }
}
```

You might need to adapt the cloudname according to what kubernetes plugin thinks your cluster name is.