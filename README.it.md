# Skill per il workflow di pianificazione

[English](README.md) · [Italiano](README.it.md)

Pacchetto di skill autonome per il workflow di pianificazione incrementale. Il loro input principale è `docs/specifications/product.md` nel repository target; requisiti, ADR e documentazione tecnica eventualmente presenti lo integrano.

1. `plan-roadmap` — gestisce la roadmap strategica in `docs/planning/roadmap.md`.
2. `plan-milestone` — dettaglia esattamente una milestone.
3. `create-tasks` — scompone una milestone approvata in task eseguibili.
4. `implement-task` — implementa e verifica un solo task `TASK-XXX`.
5. `close-milestone` — verifica e chiude una milestone.

Le skill non richiedono alcuna skill di terze parti. Possono essere usate da sole a partire da `product.md`. Le skill di Matt Pocock restano opzionali: possono servire, per esempio, a produrre o affinare `product.md`, ma non fanno parte del workflow operativo distribuito qui.

## Contenuto

```text
skills/
  plan-roadmap/
  plan-milestone/
  create-tasks/
  implement-task/
  close-milestone/
scripts/
  install.sh
  validate.sh
docs/
  operating-guide.en.md
  guida-operativa.it.md
snippets/
  AGENTS-planning-workflow.md
```

## Installazione con `npx skills`

Pubblica questa cartella in una repository GitHub, per esempio:

```text
https://github.com/blufix79/planning-workflow-skills
```

Da dentro la repository progetto del collega:

```bash
npx skills@latest add blufix79/planning-workflow-skills --skill '*' -y
```

Il comando installa le cinque skill nel progetto, normalmente sotto:

```text
.agents/skills/
```

Per installare una selezione:

```bash
npx skills@latest add blufix79/planning-workflow-skills \\
  --skill plan-roadmap plan-milestone create-tasks implement-task close-milestone -y
```

Per installarle globalmente invece che nel singolo progetto, aggiungere `-g`.

Lo script `scripts/install.sh` resta disponibile per installazioni offline o da checkout locale, ma non è necessario per il normale flusso GitHub.

Dopo l'installazione, integrare nel progetto target il contenuto di `snippets/AGENTS-planning-workflow.md` dentro `AGENTS.md`, se il workflow non è già documentato.

Per il flusso umano e gli esempi di invocazione, consulta la guida: [English](docs/operating-guide.en.md) · [Italiano](docs/guida-operativa.it.md). La preparazione di `docs/specifications/product.md` tramite `$documents` e l'uso delle skill di Matt Pocock sono esplicitamente opzionali.

## Validazione

```bash
./scripts/validate.sh
```

La validazione controlla che ogni skill abbia `SKILL.md`, front matter con soli `name` e `description`, nome coerente con la directory, e riferimenti asset essenziali presenti.

## Release e aggiornamenti

Crea una release GitHub o un tag, per esempio:

```bash
git tag v0.1.0
git push origin v0.1.0
```

Per aggiornare le skill già installate:

```bash
npx skills@latest update
```

Per distribuire un archivio offline è comunque possibile eseguire:

```bash
npm run pack:tar
```

## Dipendenze

Nessuna dipendenza da altre skill. Il repository target deve contenere un `docs/specifications/product.md` sufficientemente definito prima di avviare `plan-roadmap`.

Le skill di Matt Pocock sono facoltative: possono essere installate separatamente solo se il team vuole usarle per produrre o migliorare `product.md`.

## Licenza

[MIT](LICENSE).