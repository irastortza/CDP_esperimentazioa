# 2. Hipotesia frogatzeko sortutako datuak
Karpeta honetan bost fitxategi daude, bakoitza sortzeko honako prozedura jarraitu da:

- EDAbermerikgabe.csv: UMDA algoritmoa exekutatu da. Errenkada bakoitzak k eta instantzia batean (K-instantzia_kodea formatuarekin) egindako 25 exekuzioetan lortutako helburu-funtzioaren balioak ditu. 0 instantziak 159 nodokoa adierazten du, 1 instantziak 212 nodokoa eta 2 instantziak 265 nodokoa. k handietan UMDAk ez ditu soluzio bidergarriak ematen 0 eta 1 instantzietan.
- EDAbermearekinNAHASTUTA.csv: UMDA algoritmoa exekutatu da. Aurreko formatu bera du dokumentuak. k = 18 arte (ez barne) 0 instantziak 159 nodokoa, 1 instantziak 212 nodokoa eta 2 instantziak 265 nodokoa adierazten du. Hortik aurrera 0 instantziak 251 nodokoa adierazten du eta k=27tik aurrera (hau ere barne) 1 instantziak 263 nodokoa. Algoritmoak soluzio bideragarriak eman ditu.
- SUBSIM3LEHENAK.csv: Suberaketa simulatua algoritmoa exekutatu da. EDAbermerikgabe.csv-ren formatu bera. Soluzioak beti dira bideragarriak.
- SUBSIMBermearekinNAHASTUTA.csv: Suberaketa simulatua algoritmoa exekutatu da. EDAbermearekinNAHASTUTA.csv-ren formatu bera. Soluzioak beti dira bideragarriak.
- eraikitzaileaDatuak.csv: algoritmo eraikitzailea exekutatu da. Aurrekoaren formatu bera jarraitu da. Soluzioak beti dira bideragarriak. Azken bi k balioekin zenbaitetan ezin izan dira soluzio bideragarriak sortu eta horregatik, 0 balioa ageri da exekuzio batzuetan. 
