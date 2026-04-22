# Changelog for IncidentIo

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/).

## [0.2.0](https://github.com/sgerrand/ex_incident_io/compare/v0.1.2...v0.2.0) (2026-04-22)


### Features

* add IncidentIo.Pagination.stream/3 for cursor-based pagination ([#159](https://github.com/sgerrand/ex_incident_io/issues/159)) ([247a4ee](https://github.com/sgerrand/ex_incident_io/commit/247a4eec0e17f3c0e9b7699da05370d78dff4003))


### Bug Fixes

* **alert_events_v2:** URL-encode token via add_params_to_url ([#151](https://github.com/sgerrand/ex_incident_io/issues/151)) ([c620af2](https://github.com/sgerrand/ex_incident_io/commit/c620af218b0bc29a307cc58815840419a370c2b6))
* **catalog_entry_v2:** correct typespec referencing nonexistent module ([#149](https://github.com/sgerrand/ex_incident_io/issues/149)) ([bfa4364](https://github.com/sgerrand/ex_incident_io/commit/bfa4364da3094a9a27f776b22d94a8b4bdbb5122))
* **incidents_v1:** prevent nil values being sent as query params ([#150](https://github.com/sgerrand/ex_incident_io/issues/150)) ([dab264b](https://github.com/sgerrand/ex_incident_io/commit/dab264b751ca41034dd4eb8a02eccb7be31fc361))
* **open_api_v1:** use caller-provided client instead of blank default ([#148](https://github.com/sgerrand/ex_incident_io/issues/148)) ([139292b](https://github.com/sgerrand/ex_incident_io/commit/139292bb0f967bef191537f216bd4003bf6e6a14))


## [0.1.2](https://github.com/sgerrand/ex_incident_io/compare/v0.1.1...v0.1.2) (2026-04-21)

### Dependencies

* replace HTTPoison and ExVCR with Req ([#142](https://github.com/sgerrand/ex_incident_io/issues/142)) ([c255f77](https://github.com/sgerrand/ex_incident_io/commit/c255f77f45b87cfe4d8ffa41ddf398b4137d2493))


## [0.1.1](https://github.com/sgerrand/ex_incident_io/compare/v0.1.0-dev...v0.1.1) (2025-08-28)


### Dependencies

* Bump httpoison from 2.2.2 to 2.2.3 ([ec2444f](https://github.com/sgerrand/ex_incident_io/commit/ec2444f241e094c5a60b4e5eb3f4767d2f044ef8))

### Continuous Integration

* Pin action references to specific commits ([288740d](https://github.com/sgerrand/ex_incident_io/commit/288740da5a838244b0aff527dd9761cefee18541))
* Prevent potential cache poisoning attack ([d6d7e03](https://github.com/sgerrand/ex_incident_io/commit/d6d7e03d4145a2d063320067c3a9a45eaee438b8))
* Prevent version control credentials from being persisted ([eb3fcd0](https://github.com/sgerrand/ex_incident_io/commit/eb3fcd0839020620d635c6bc198b6d96b971b78a))

## [0.1.0](https://github.com/sgerrand/ex_incident_io/tree/v0.1.0) (2024-07-03)

- Initial release
