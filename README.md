# Oncology-DM-SDTM-mapping
SDTM Demographics (DM) dataset for an oncology study, mapped from CRF using CDISC standards.

# Oncology DM SDTM Dataset

This repository contains the **Demographics (DM) domain** of an oncology clinical trial, structured according to the **CDISC SDTM (Study Data Tabulation Model) standards**.  
The dataset was generated using the **CDISC Dataset Generator** and mapped from **Case Report Form (CRF) fields**.

---

## 📂 Repository Contents
- `dm.xpt` – SDTM-compliant DM dataset in XPT format  
- `dm.csv` – Exported dataset in CSV format  
- `sdtm_mapping.xlsx` – Mapping of CRF fields to SDTM DM variables  
- `README.md` – Documentation of repository contents  

---

## 🧾 Domain Overview: DM (Demographics)
The **DM domain** provides subject-level demographic and trial information.  
Key variables include:  
- `STUDYID` – Study identifier  
- `USUBJID` – Unique subject identifier  
- `ARM` / `ARMCD` – Planned treatment arm  
- `SEX`, `AGE`, `RACE`, `ETHNIC` – Demographic attributes  
- `RFSTDTC`, `RFENDTC` – Subject reference start and end dates  

---

## ⚙️ How the Dataset Was Generated
- Source: **CDISC Dataset Generator**  
- Therapeutic Area: **Oncology**  
- Mapped from **CRF fields to SDTM variables**  
- Ensures alignment with **CDISC SDTM v3.2 standards**  

---

## 📖 References
- [CDISC SDTM Implementation Guide](https://www.cdisc.org/standards/foundational/sdtm)  
- [CDISC Dataset Generator](https://cdisc.org/tools/dataset-generator)  

---

## 🧑‍💻 Author
**Anjale Ramesh**  
Ph.D. in Statistics | Data Science & Clinical Research Enthusiast  

