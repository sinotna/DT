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
