-- Politent WP1.4 — seed SCB population/context source registry

INSERT INTO source_registry
(source_id, source_name, source_url, license_or_access, jurisdiction, unit_of_analysis, time_coverage, geo_coverage, notes)
VALUES
('SCB_CTX_POP_AGE_SEX_DESO','SCB population by DeSO/RegSO, age and sex','https://www.statistikdatabasen.scb.se/pxweb/en/ssd/START__BE__BE0101__BE0101Y/FolkmDesoAldKon/','OPEN','Sweden','regional statistical table','2010-2025','DeSO/RegSO','Matrix 000007Y7'),
('SCB_CTX_BIRTHREGION_SEX_DESO','SCB population by DeSO/RegSO, region of birth and sex','https://www.statistikdatabasen.scb.se/pxweb/en/ssd/START__BE__BE0101__BE0101Y/FolkmDesoLandKon/','OPEN','Sweden','regional statistical table','2010-2025','DeSO/RegSO','Matrix 000007Y5'),
('SCB_CTX_LABOUR_DESO','SCB labour-market status by DeSO/RegSO, sex and age','https://www.statistikdatabasen.scb.se/pxweb/en/ssd/START__AM__AM0210__AM0210G/ArRegDesoStatusN/','OPEN','Sweden','regional statistical table','2020-2024','DeSO/RegSO','Matrix 0000089X'),
('SCB_CTX_EDUCATION_DESO','SCB education by DeSO/RegSO','https://www.statistikdatabasen.scb.se/pxweb/en/ssd/START__UF__UF0506__UF0506D/UtbSUNBefDesoRegsoN/','OPEN','Sweden','regional statistical table','2024-2025','DeSO/RegSO','Matrix 000007Z6'),
('SCB_CTX_INCOME_DESO','SCB income structure by DeSO/RegSO and sex','https://www.statistikdatabasen.scb.se/pxweb/en/ssd/START__HE__HE0110__HE0110I/Tab2InkDesoRegso/','OPEN','Sweden','regional statistical table','2011-2024','DeSO/RegSO','Matrix 000008A4')
ON CONFLICT (source_id) DO NOTHING;

INSERT INTO population_context_source
(context_source_id, source_id, matrix_id, title, landing_page, time_coverage, unit, reference_time, joint_dimensions, geo_version_rule, disclosure_note)
VALUES
('SCB_CTX_POP_AGE_SEX_DESO','SCB_CTX_POP_AGE_SEX_DESO','000007Y7','Population per region by age and sex','https://www.statistikdatabasen.scb.se/pxweb/en/ssd/START__BE__BE0101__BE0101Y/FolkmDesoAldKon/','2010-2025','number','31 December each year','["region","age","sex","year"]'::jsonb,'{"through_2023":"DeSO 2018","from_2024":"DeSO 2025"}'::jsonb,'Retain annual source disclosure metadata.'),
('SCB_CTX_BIRTHREGION_SEX_DESO','SCB_CTX_BIRTHREGION_SEX_DESO','000007Y5','Population per region by region of birth and sex','https://www.statistikdatabasen.scb.se/pxweb/en/ssd/START__BE__BE0101__BE0101Y/FolkmDesoLandKon/','2010-2025','number','31 December each year','["region","region_of_birth","sex","year"]'::jsonb,'{"through_2023":"DeSO 2018","from_2024":"DeSO 2025"}'::jsonb,'SCB documents CTA through 2024 and Cell Key Method from 2025 for this table.'),
('SCB_CTX_LABOUR_DESO','SCB_CTX_LABOUR_DESO','0000089X','Labour market status by DeSO/RegSO, sex and age','https://www.statistikdatabasen.scb.se/pxweb/en/ssd/START__AM__AM0210__AM0210G/ArRegDesoStatusN/','2020-2024','number','year','["observation","region","sex","age","year"]'::jsonb,'{"through_2023":"DeSO 2018","from_2024":"DeSO 2025"}'::jsonb,'Reported totals can differ from sums because of disclosure protection.'),
('SCB_CTX_EDUCATION_DESO','SCB_CTX_EDUCATION_DESO','000007Z6','Population 25-65 by DeSO/RegSO and educational attainment','https://www.statistikdatabasen.scb.se/pxweb/en/ssd/START__UF__UF0506__UF0506D/UtbSUNBefDesoRegsoN/','2024-2025','number of persons','year','["region","education_level","year"]'::jsonb,'{"from_2024":"DeSO 2025"}'::jsonb,'Some persons not linked below municipality are assigned within municipality.'),
('SCB_CTX_INCOME_DESO','SCB_CTX_INCOME_DESO','000008A4','Income structure net income by DeSO/RegSO and sex','https://www.statistikdatabasen.scb.se/pxweb/en/ssd/START__HE__HE0110__HE0110I/Tab2InkDesoRegso/','2011-2024','mixed','31 December each year','["observation","region","sex","year"]'::jsonb,'{"rule":"Read classification from source metadata at extraction time"}'::jsonb,'Use primarily as contextual covariate unless a direct joint frame is explicitly supported.')
ON CONFLICT (context_source_id) DO UPDATE SET
matrix_id=EXCLUDED.matrix_id,
title=EXCLUDED.title,
landing_page=EXCLUDED.landing_page,
time_coverage=EXCLUDED.time_coverage,
joint_dimensions=EXCLUDED.joint_dimensions,
geo_version_rule=EXCLUDED.geo_version_rule,
disclosure_note=EXCLUDED.disclosure_note;
