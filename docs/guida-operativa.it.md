# Guida operativa

> Mantieni questa guida allineata con la [versione inglese](operating-guide.en.md).

Questa guida descrive il workflow umano per le skill di pianificazione. Le skill del pacchetto sono autonome: richiedono una specifica di prodotto approvata in `docs/specifications/product.md`, non altre skill.

## Prima di iniziare

Apri il tuo agente dalla root del repository. Per attivare una skill in modo prevedibile, nominala all'inizio del messaggio:

```text
$nome-skill richiesta, file da leggere, vincoli e risultato atteso
```

Una singola invocazione ha un obiettivo delimitato. In particolare, `implement-task` lavora sempre su un solo task.

## Preparare `product.md`

`docs/specifications/product.md` è la fonte primaria per le skill di questo pacchetto. Deve descrivere almeno obiettivo, utenti, requisiti funzionali e non funzionali, vincoli, fuori ambito, criteri di accettazione, rischi e decisioni aperte.

### Opzione: normalizzare un documento sorgente

Se il punto di partenza è un DOCX, PDF o altro documento non strutturato, usa una skill documentale disponibile nel tuo ambiente oppure una revisione umana per produrre e approvare `docs/specifications/product.md`. Per esempio, se è installata una skill `$documents`:

```text
$documents Leggi completamente docs/sources/project-description.docx e trasformalo in docs/specifications/product.md. Non creare roadmap, milestone, task o codice. Prima di salvare mostrami lacune, contraddizioni, interpretazioni e struttura proposta.
```

`$documents` è opzionale e **non** è inclusa né richiesta da questo pacchetto.

### Opzione: skill di Matt Pocock

Le skill di [Matt Pocock](https://github.com/mattpocock/skills) sono opzionali. Possono aiutare a chiarire il dominio, stressare requisiti e ricercare decisioni aperte prima dell'approvazione di `product.md`; non sono necessarie per eseguire il workflow qui sotto.

Esempi, se installate:

```text
$domain-modeling Analizza docs/specifications/product.md e chiarisci termini, entità e regole di dominio.

$grill-with-docs Revisiona docs/specifications/product.md e individua ambiguità, contraddizioni e requisiti non verificabili.

$research Ricerca esclusivamente la decisione aperta <tema>; presenta evidenze e trade-off senza modificare la specifica.
```

## Workflow

| Fase | Skill | Artefatto principale | Gate umano |
| --- | --- | --- | --- |
| 1 | `plan-roadmap` | `docs/planning/roadmap.md` | MVP, milestone, ordine e dipendenze |
| 2 | `plan-milestone` | `docs/planning/milestones/MXX-slug.md` | ambito, criteri e verifica |
| 3 | `create-tasks` | `docs/planning/tasks/TASK-XXX-slug.md` | elenco, granularità e dipendenze |
| 4 | `implement-task` | codice e task aggiornato | verifiche e risultato |
| 5 | `close-milestone` | `docs/reviews/milestones/MXX-review.md` | solo `PASSED` chiude la milestone |

### 1. Roadmap

```text
$plan-roadmap Crea la roadmap partendo da docs/specifications/product.md, CONTEXT.md, architettura, ADR e stato reale del repository. Distingui MVP e post-MVP; mostrami la bozza prima di scrivere. Non creare milestone dettagliate né task.
```

### 2. Una milestone

```text
$plan-milestone Pianifica M01. Leggi roadmap, project-status, docs/specifications/product.md, CONTEXT.md, architettura e ADR. Definisci ambito, fuori ambito, rischi, requisiti applicabili, risultato dimostrabile, criteri di completamento e strategia di verifica. Non creare task né codice.
```

### 3. Task della milestone

```text
$create-tasks Scomponi M01 in task eseguibili in una sola sessione. Mostrami prima risultato osservabile, dipendenze, criteri e motivazione della granularità. Scrivi i file solo dopo la mia approvazione. Non implementare.
```

### 4. Un task

```text
$implement-task Implementa docs/planning/tasks/TASK-001-slug.md. Lavora solo su questo task, verifica blocker e fonti di verità, quindi esegui i controlli applicabili. Non dichiararlo completed se un criterio o una verifica obbligatoria fallisce.
```

Per selezionare il prossimo task pronto:

```text
$implement-task Esegui il prossimo singolo task ready della milestone M01 i cui blocker sono completati.
```

### 5. Chiusura della milestone

```text
$close-milestone Verifica M01 contro risultato reale, obiettivo, criteri, docs/specifications/product.md, requisiti applicabili e ADR. Crea il report di review. Se emergono blocchi, proponi task correttivi senza crearli prima della mia approvazione.
```

## Dopo la review

- Esito `PASSED`: pianifica la milestone successiva con `plan-milestone`.
- Scope, ordine o dipendenze cambiati: torna a `plan-roadmap` e approva la revisione.
- Esito `FAILED` o `BLOCKED`: approva i task correttivi, creali con `create-tasks` e implementali uno alla volta.

## Regole essenziali

- Non chiedere roadmap, milestone, task e implementazione nella stessa invocazione.
- Non generare task di milestone lontane.
- Non implementare più task insieme.
- Lo stato `completed` dei task non dimostra, da solo, che la milestone sia completata.
- Segnala conflitti con scope, requisiti o ADR; non risolverli silenziosamente.
- I comandi shell servono a installare o controllare file; le skill si invocano nella chat del proprio agente.
