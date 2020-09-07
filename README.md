# Robot Framework Stack


Vzorový projekt slouží k demonstraci možností logování RF testů skrze listener do ElasticSearche a pak následně do Kibany

### Instalace

Pro spouštění automatizovaných testů je třeba mít na PC nainstalován Python 3.7 a 
dále doinstalovat potřebné knihovny pomocí příkazu
```
pip install requirements.txt
```
TXT soubor je součástí Git repozitory

Některé testy při svém běhu spouští i webový prohlížeč. Pro správnou funkci si z URL: https://chromedriver.chromium.org/ 
stáhněte verzi pro Windows. Číslo verze se musí shodovat s verzí Chrome, který máte aktuálně nainstalovaný.
Stažený ZIP soubor rozbalte a nahrajte do adresáře, ke kterému je nutné v systémových proměnných do PATH doplnit cestu.

## Spouštění

### Jenkins


### Lokálně

Obecně se testy pouští příkazem:
```
robot -i api -d Results/Result-XXX --logtitle "Nadpis HTML stranky s Results - RF Stack" --variable JENKINS_BUILD_URL:"localhost:8081" Tests
```
Přepínač **-i** určuje TAG testů, které se bude spouštět.  Pokud chceme spustit jeden konkrétní test, 
můžeme použít **-t JMENO_TESTU**  . Pokud dáme **--variable HEADLESS:"False"** , tak při testu se na ploše spustí viditelně prohlížeč Chrome. 
V případě **True** se prohlížeč vykresluje jen v paměti a není vidět na ploše.

Detailní popis možný parametrů pro spuštění naleznete zde: http://robotframework.org/robotframework/2.9b2/RobotFrameworkUserGuide.html#all-command-line-options 

Pokud chceme využít i listenery pro odesílání do Elastic, Allure a Report portal současně, použijeme příkaz:
```
robot -i rfstack --listener Listener/PythonListener.py --listener allure_robotframework:Results/allure --listener robotframework_reportportal.listener --variable RP_UUID:"65c278c5-dec2-4e92-9865-5adfee24e26a" --variable RP_ENDPOINT:"http://portal.tesena.com" --variable RP_LAUNCH:"tomas.hak_TEST_EXAMPLE" --variable RP_PROJECT:"tomas_hak_personal"  Tests
```

## Tests data

Očekává se běžící elasticsearch na url: localhost:9200   , pokud se parametrem nedefinuje jinak.