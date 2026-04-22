# Changelog for IncidentIo

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/).

## [0.3.0](https://github.com/sgerrand/ex_incident_io/compare/v0.2.0...v0.3.0) (2026-04-22)


### Features

* add AlertPrioritiesV2 module for listing alert priorities ([#170](https://github.com/sgerrand/ex_incident_io/issues/170)) ([32efac5](https://github.com/sgerrand/ex_incident_io/commit/32efac59f18906dbca940559dcb6a6b53c42c615))
* add AlertRoutesV2 module for alert route management ([#164](https://github.com/sgerrand/ex_incident_io/issues/164)) ([6b9f547](https://github.com/sgerrand/ex_incident_io/commit/6b9f547328cf3481c9078986d04b44a819654c5f))
* add AlertSourcesV2 module for listing alert sources ([#165](https://github.com/sgerrand/ex_incident_io/issues/165)) ([00711f8](https://github.com/sgerrand/ex_incident_io/commit/00711f885aca203d05d02993dc1b0b7f3e16d934))
* add AlertsV2 module for alert management ([#163](https://github.com/sgerrand/ex_incident_io/issues/163)) ([1951d9e](https://github.com/sgerrand/ex_incident_io/commit/1951d9eff6d796ca834d61866154e802fff25532))
* add ApiKeysV1 module for API key management ([#162](https://github.com/sgerrand/ex_incident_io/issues/162)) ([15d1355](https://github.com/sgerrand/ex_incident_io/commit/15d1355e3ad13e2015b22b6da1b430f932c359e7))
* add CatalogTypesV3 and CatalogEntriesV3 modules ([#172](https://github.com/sgerrand/ex_incident_io/issues/172)) ([fd69163](https://github.com/sgerrand/ex_incident_io/commit/fd69163bba9b3349ad3bae9c451cb256f9705b3b))
* add EscalationPathsV2 module for escalation path management ([#171](https://github.com/sgerrand/ex_incident_io/issues/171)) ([06c668c](https://github.com/sgerrand/ex_incident_io/commit/06c668ca9d7d5ab824f834ad0740465d61fbba2f))
* add IncidentRelationshipsV1 module ([#166](https://github.com/sgerrand/ex_incident_io/issues/166)) ([4ec16f2](https://github.com/sgerrand/ex_incident_io/commit/4ec16f24fe8e27c120b69340071b25e5c02cd0a2))
* add MaintenanceWindowsV2 module ([#167](https://github.com/sgerrand/ex_incident_io/issues/167)) ([0776d10](https://github.com/sgerrand/ex_incident_io/commit/0776d107a2e07a06a56ad55454ed86feaddcb9b7))
* add PostMortemsV2 module ([#168](https://github.com/sgerrand/ex_incident_io/issues/168)) ([6c4a94d](https://github.com/sgerrand/ex_incident_io/commit/6c4a94d85a21e3416bd960a959456eca771d96c9))
* complete CRUD operations for actions, follow-ups, and incident types ([#161](https://github.com/sgerrand/ex_incident_io/issues/161)) ([3027200](https://github.com/sgerrand/ex_incident_io/commit/3027200015cdebfa8b56f2565b456841db30a6d6))


### Bug Fixes

* **docs:** correct copy-paste errors in [@doc](https://github.com/doc) examples ([#175](https://github.com/sgerrand/ex_incident_io/issues/175)) ([aaf6b22](https://github.com/sgerrand/ex_incident_io/commit/aaf6b22fcb169f3afcb2ba104811119661061ca2))
* replace drop_while with Enum.reject for nil-filtering in FollowUpsV2 ([#173](https://github.com/sgerrand/ex_incident_io/issues/173)) ([07aa0cd](https://github.com/sgerrand/ex_incident_io/commit/07aa0cd1edae516dc8abdb5e28aee4b425b46365))

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
