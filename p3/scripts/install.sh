#!/bin/bash

# 1️⃣ Création du cluster Kubernetes avec k3d
echo "🚀 Création du cluster Kubernetes..."
k3d cluster create my-cluster
kubectl create namespace argocd
kubectl create namespace dev

# 4️⃣ Installation d'ArgoCD
echo "📦 Installation d'ArgoCD..."
kubectl apply -n argocd -f https://raw.githubusercontent.com/argoproj/argo-cd/stable/manifests/install.yaml

# 5️⃣ Attente qu'ArgoCD soit prêt
echo "⏳ Attente du démarrage des pods ArgoCD..."
kubectl wait --for=condition=Ready pods -n argocd --all --timeout=300s

# 6️⃣ Récupération et affichage du mot de passe admin ArgoCD
echo "🔑 Récupération du mot de passe admin d'ArgoCD..."
ARGO_PWD=$(kubectl -n argocd get secret argocd-initial-admin-secret -o jsonpath="{.data.password}" | base64 -d)
echo "🔑 Mot de passe admin : $ARGO_PWD"
kubectl port-forward svc/argocd-server -n argocd 8080:443 &  # 🔄 Lancement du port-forwarding pour l'accès à l'interface web d'ArgoCD
sleep 5

# 8️⃣ Connexion à ArgoCD via CLI
echo "🔗 Connexion à ArgoCD CLI..."
argocd login localhost:8080 --username admin --password $ARGO_PWD --insecure  # 🔑 Connexion avec les identifiants admin

# 9️⃣ Ajout du dépôt Git à ArgoCD
echo "📂 Ajout du dépôt Git à ArgoCD..."
argocd repo add https://github.com/Pirabaud/pirabaud --insecure  # 🗂️ Ajout du dépôt Git pour récupérer les manifs Kubernetes

argocd login cd.argoproj.io --core  # 🔄 Connexion à ArgoCD via le Kubernetes API Server
kubectl config set-context --current --namespace=argocd  # 🔄 Mise à jour du contexte pour travailler dans le namespace `argocd`

# 🔟 Déploiement de l'application ArgoCD
echo "🚀 Création de l'application ArgoCD..."
 argocd app create playground-app \
  --repo https://github.com/Pirabaud/pirabaud \
  --path "." \
  --dest-server https://kubernetes.default.svc \
  --dest-namespace dev \
  --sync-policy automated \
  # 🔄 Création de l'application avec synchronisation automatique activée

# 1️⃣1️⃣ Synchronisation de l'application
echo "🔄 Synchronisation de l'application..."
argocd app sync playground-app  # 🔄 Synchronisation de l'application pour appliquer les modifications à partir du dépôt Git

# 1️⃣2️⃣ Changement de namespace vers dev
echo "🔄 Changement du namespace vers dev..."
kubectl config set-context --current --namespace=dev  # 🔄 Changement de namespace pour passer au namespace `dev`

# 1️⃣3️⃣ Attente que le pod soit dans le statut Running avant de continuer
#echo "⏳ Attente que le pod soit Running..."
kubectl wait --for=condition=ready pod -n dev -l app=will-playground --timeout=300s

# 1️⃣4️⃣ Récupérer le nom du pod dans dev
#POD_NAME=$(kubectl get pods -n dev -l app=will-playground -o jsonpath='{.items[0].metadata.name}')
# 1️⃣5️⃣ Lancer le port-forward sur le pod de l'app sur le port 8888
echo "🔄 Lancement du port-forward..."
while true; do
    kubectl port-forward svc/will-playground -n dev 8888:80
    echo "Le port-forwarding a été interrompu. Tentative de reconnexion dans 5 secondes..."
    sleep 5
done