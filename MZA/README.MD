MZA - SMARTHOME
ερωτήσεις
 - Azure πως βλέπω ποιο είναι το prod/preprod/sandbox.
 - Τρέχει το magenta zu hausze σε hardware ή στο κινητό.

TODO: να βρω το κατάλληλο azure training.

*Smarthome: είναι το παλιό και επικοινωνέι με τους routers/devices των πελατών με παλιά πρωτόκολλα επικοινηνωνίας. Σε αυτό το hardware θα συνδεθούν όλες οι smart συσκευύες.

MAGENTA ZU HAUSE : νέα προτόκολλα είναι το νέο. 



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
