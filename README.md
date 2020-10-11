# SparkStarterKitForStudents


## Note rendu intermédiaire - 3/3

### Description
La partie IOS nous sert d'interface pour communiquer avec le drone et nos 3 spheros. Le code est en swift et nous utilisons des SDK pour faciliter notre développement.

### Structure
* L'ensemble de nos classes métiers se trouve dans le dossier `SparkPerso/SparkPerso/Core`. Voici un aperçu de sa structure :
```
.
├── Activities
│   ├── BaseActivity.swift
│   ├── CollectCluesActivity.swift
│   └── DogActivity.swift
├── Helpers
│   ├── CommunicationHelper.swift
│   └── Debugger.swift
├── Managers
│   ├── Camera
│   │   └── DroneCameraManager.swift
│   ├── Pilots
│   │   ├── Contracts
│   │   │   ├── PilotManager.swift
│   │   │   ├── ThreeDimDirections.swift
│   │   │   ├── ThreeDimPilotManager.swift
│   │   │   ├── TwoDimDirections.swift
│   │   │   └── TwoDimPilotManager.swift
│   │   ├── DronePilotManager.swift
│   │   └── SpheroPilotManager.swift
│   └── Sequencies
│       ├── DroneSequenciesManager.swift
│       └── States
│           ├── BackwardStateSequence.swift
│           ├── DownStateSequence.swift
│           ├── ForwardStateSequence.swift
│           ├── LandingStateSequence.swift
│           ├── LeftStateSequence.swift
│           ├── RightStateSequence.swift
│           ├── StateSequence.swift
│           ├── StopStateSequence.swift
│           ├── TakeOffStateSequence.swift
│           └── UpStateSequence.swift
└── Route
    └── Router.swift 
```

* Nous avons représenté un manager pour un besoin métier spécifique (exemple: piloter la sphéro -> `SpheroPilotManager`).
* Pour que l'application IOS récupère bien les messages en provenance du serveur NodeJS, il faut que la vue `SandboxViewController` soit active puisque c'est dans celle-ci que nous initialisons le Bridge USB ainsi que la classe `Router` du fichier `Core/Route/Router.swift`
* Lorsque le Router récupère les messages en provenance du serveur NodeJS, il va exécuter l'action de la bonne activité en passant en paramètre le device ciblé.

### Etape pour mettre en place toute l'architecture
1. Allumer le serveur NodeJS
2. Build l'application IOS
3. Aller dans la vue SandBoxViewController et appuyer sur le bouton `Bridge`
4. Se connecter aux interfaces Web et lancer les activités