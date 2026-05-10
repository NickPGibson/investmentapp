# InvestNest

Investment portfolio viewing platform for investment advisors. Advisors can see their clients and the assets that the client owns. The advisor can also view all the assets and the clients who own them.

This is a portfolio piece and as such, there is no real backend. Instead, a local SQLite database is used to seed and serve data, standing in for what would otherwise be a remote API.

Supported on iOS, Android, web and macOS.

Hosted here: https://nickpgibson.github.io/investmentapphosting/

## Architecture

The codebase follows Clean Architecture, organised by feature. Each feature is split into three layers, with dependencies flowing inward toward the domain.

```
lib/
├── features/
│   ├── clients/
│   │   ├── domain/        ← entities, repository interfaces, use cases  (pure Dart)
│   │   ├── data/          ← models, repository implementations          (depends on domain)
│   │   └── presentation/  ← BLoCs, pages                                (depends on domain)
│   ├── assets/            ← same three-layer structure
│   └── home/              ← presentation only (tab scaffold)
├── shared/
│   ├── data/datasources/  ← PortfolioLocalDataSource (sqflite)
│   └── services/          ← ImageService
├── widgets/               ← reusable UI primitives (InfoCard, RoundedCard, Heading, …)
├── utils/                 ← formatters (toSterling)
├── injection_container.dart  ← GetIt wiring
└── main.dart                 ← go_router + theme
```

### Domain layer

Pure Dart, no Flutter or persistence imports.

- **Entities** — `Client`, `Asset`. Immutable, `Equatable`, hold only the fields the app reasons about.
- **Repository interfaces** — `ClientRepository`, `AssetRepository`. Abstract contracts owned by the domain; the data layer depends on these, not the other way around.
- **Use cases** — one callable per operation (`GetAllClientsUseCase`, `GetAssetsOfClientUseCase`, `GetAllAssetsUseCase`, `GetClientsOfAssetUseCase`). Each takes a repository in its constructor and exposes a single `call()` method, keeping business-logic plumbing out of the presentation layer.

### Data layer

- **Models** — `ClientModel extends Client`, `AssetModel extends Asset`. The model adds `fromMap` / `toMap` for SQLite serialisation, so persistence concerns never leak into the domain.
- **Repository implementations** — `ClientRepositoryImpl`, `AssetRepositoryImpl`. Depend on `PortfolioLocalDataSource` and return domain types.
- **Persistence boundary** — `PortfolioLocalDataSource` (sqflite) is the only class that knows about SQL. Swapping to a remote API would only touch this class and its DI registration.

### Presentation layer

- One BLoC per screen, built on `flutter_bloc`.
- States are sealed classes (`Initial` / `Loading` / `Loaded`), enabling exhaustive `switch` in the UI.
- BLoCs depend only on use cases — never on repositories or data sources directly.
- Pages wrap the BLoC in `BlocProvider` → `BlocBuilder`.

### Dependency injection

`GetIt` wires the graph in `init()` (`lib/injection_container.dart`):

- `PortfolioLocalDataSource`, `ImageService` — singletons.
- Repositories and use cases — lazy singletons.
- BLoCs — factories so each navigation gets a fresh instance.

### Money handling

Monetary values use the `decimal` package end-to-end: `Decimal` on entities, stored as `TEXT` in SQLite, formatted with `intl` at the UI boundary (`toSterling` in `lib/utils/utils.dart`). `double` is never used for currency.

## Testing

Tests mirror the architecture — each layer is tested in isolation against a mock of the layer below.

| Layer        | Test file                       | What it covers                                                              | Mocks                      |
|--------------|---------------------------------|-----------------------------------------------------------------------------|----------------------------|
| Entity       | `test/entity_test.dart`         | `Equatable` props, equality, hashCode for `Client` and `Asset`.             | none                       |
| Use case     | `test/use_case_test.dart`       | Each use case delegates to the correct repository method and only that one. | `*Repository`              |
| BLoC         | `test/bloc_test.dart`           | Each BLoC emits `Loading` then `Loaded` for its fetch event (`bloc_test`).  | `*UseCase`                 |
| Widget (e2e) | `test/clients_widget_test.dart` | Boots `InvestmentApp`, navigates clients tab → client detail.               | `PortfolioLocalDataSource` |
| Widget (e2e) | `test/assets_widget_test.dart`  | Boots `InvestmentApp`, navigates assets tab → asset detail.                 | `PortfolioLocalDataSource` |

`mocktail` for mocks, `bloc_test` for BLoC behaviour. The widget tests reset the `GetIt` container in `setUp` and re-register the dependency graph with the data source mocked, so the whole app runs against in-memory data without touching sqflite.

```
flutter test
```

## Screenshots

<img width="343" alt="Screenshot 2025-01-12 at 13 49 17" src="https://github.com/user-attachments/assets/94e162b3-99d0-49fb-a245-4c4ecb1cc7d7" />
<img width="905" alt="Screenshot 2025-01-12 at 13 51 53" src="https://github.com/user-attachments/assets/2dbcbc1a-dfcf-416a-a407-9e60b276ace5" />
<img width="732" alt="web" src="https://github.com/user-attachments/assets/3f01674d-f2a2-4872-adb7-7573288c2495" />
<img width="1104" alt="Screenshot 2025-01-12 at 16 27 40" src="https://github.com/user-attachments/assets/c704426d-a667-46f2-91bf-019b020d81e0" />
