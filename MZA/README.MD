MZA - SMARTHOME
ερωτήσεις
 - Azure πως βλέπω ποιο είναι το prod/preprod/sandbox.
 - Τρέχει το magenta zu hausze σε hardware ή στο κινητό.

TODO: να βρω το κατάλληλο azure training.

*Smarthome: είναι το παλιό και επικοινωνέι με τους routers/devices των πελατών με παλιά πρωτόκολλα επικοινηνωνίας. Σε αυτό το hardware/gateway θα συνδεθούν όλες οι smart συσκεύες. Ειναι dedicated device με το δικό του firmware. έχει και smart application.

Τα πρωτοκόλλα με την επικοινωνία των smart devices που θα πρέπει να ήταν συμβατα με το smarthome.

MAGENTA ZU HAUSE : Μιλάει με το cloud api των εταιριων (philps,xiaomi,soofon...) έτσι μπορεί να υποστιρίξει πολλές συσκευές. δε χρειάζεται gateway/dedicated device όπως το smarthome. 

Ακριβώς όπως το google home.



Όλα τρέχουν στο AZURE σε AKS. Εκτός από το firmware server που τρέχει σε ένα ubuntu με nginx.

Οι δουλειές γίνονται με Terraform αλλά εκτελείται από gitlab pipelines.

ArgoCD.

Humio είναι το αντίστοιχο ELK. Τώρα έχουμε μεταφερθεί στο homeOS με opensearch.

Istio είναι για το mesh και το virtual service (proxy).

AZURE

Sandbox: dtit_cnd0002
Preprod: dtit_cnp0001
Prod:dtit_cnp0020


Υπάρχουν services που τρέχουν στο AKS και άλλα σε VMS.

Service
-Sentry : το χρησιμοπειούν οι devs.
-qberd : είναι το smarthome application (legacy)
    - MPS : messaging proxy service επιτρέπει στα gateway devices που βρίσκονται στα σπίτια των πελατών να μιλάνε με το smarthome στο Azure.  
-ISTIO : Mesh encrypstion + ingress
-NGINX Ingress : Χρησιμοποιήται και αυτό παράλληλα με το istio ingress. 


Terraform. 
όλα τα envs τρέχουν με pipelines. υπάρχουν docker images με TF και parsaρονται οι εντολές στα docker. Στο pipeline θα πάρουμε το output.


--- KRUM ---
Secrets management.
We are using azure key vault.  


Deploy to production we are creating a new git tag.

ARGOCD is deploying only ISTIO and some DEV applications.

---CMP Project---
Phoenix CMP is responsible for upgrading images or factory reset. 
https://gitlab.devops.telekom.de/mhe/cloud/mza/gateway/phoenix-cmp/-/jobs/148657630
This project is using kustomize instead of helm chart. 

Το μόνο που έχουμε να αλλάξουμε το version του image και το κάνουμε push. και πάμε στο pipeline για να τρέξουμε στο env που θέλουμε.
Φτιάχνουμε ένα branch και ζητάμε να μας το κάνουν apparove.
Slack Request: https://consumeriot.slack.com/archives/C045YTXQAQ3/p1708512039285899?thread_ts=1708426991.961659&cid=C045YTXQAQ3
Gitlab Repo file: https://gitlab.devops.telekom.de/mhe/cloud/mza/gateway/phoenix-cmp/-/blob/master/control-center/resources/kustomization.yaml?ref_type=heads#L19
GitLab MR: https://gitlab.devops.telekom.de/mhe/cloud/mza/gateway/phoenix-cmp/-/merge_requests/9

azure data studio


## Pipelines and Runnes

*Information about the runners https://docs.devops.telekom.de/*
*For docker in docker we have to add this: https://gitlab.devops.telekom.de/mhe/cicd/work-horse/image/-/blob/3cfe0e7871c7fcf979c9f339ad129d363d06beac/.gitlab-ci.yml#L39-39*

Replace only the Virtual machines runners. Ask Dau and Ralf

Gitlab runners uses sysbox
Our runners are using docker service. 

*Use gitlab runners as much as possibe.*

- We are using our runners because of authorization. e.g. We are passing the credentials for accessing azure etc.
- We are using our runners for docker in docker


## CICD Global pipeline
https://gitlab.devops.telekom.de/mhe/cloud/cicd
Used for Java,Cotlin...
