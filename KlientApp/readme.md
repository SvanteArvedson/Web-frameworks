#Klientapplikationen

##Så här gör du för att installera applikationen
För att applikationen ska kunna köras så måste Registreringsapplikationen, WebApiet och 
Klientapplikationen laddas ner och installeras. Alla delarna innehåller nödvändiga bitar 
för att klientapplikationen ska fungera.

###Registreringsapplikationen
+ Ladda ner koden till din RoR-miljö (katalogen *RegistrationApp*)
+ Kör kommandot *bundle install* för att installera de gems som applikationen använder
+ Kör kommandot *rake db:seed* för att ladda databasen med testdata

###Webb api:et
+ Ladda ner koden till din RoR-miljö (katalogen *WebApi*)
+ Kör kommandot *bundle install* för att installera de gems som applikationen använder
+ Kör kommandot *rake db:seed* för att ladda databasen med testdata
+ Kör kommandot *rails s* för att starta servern

###Klientapplikationen
+ Ladda ner koden till din Javascript-miljö (katalogen *KlientApp*)
+ Byt ut basurl:en i filen *app/services/constants/api.js* och i taggen <base> i filen *index.html*
+ Öppna applikationen i din webbläsare (notera att konfigurationen av url-anrop endast fungerar på apache.servar >= 2)

####Kontouppgifter
+ Email: *creator.one@example.com*
+ Lösenord: *hemligt*

##Ändringar gjorda i api:et under den här laborationen
Jag fick ändra ganska mycket i min sökfunktionalitet. Tidigare hade jag endast tänkt göra det 
möjligt att söka på ord som skulle matchas mot story.name och story.description men kom under 
den här laborationen på att det även skulle vara bekvämt att kunna söka på berättelsernas 
skapare och taggar också, och ännu mer att kunna söka på dessa parametrar i kombination. Detta 
är nu möjligt att göra ch görs av min klientapplikation. I övrigt har jag endast ändrat buggar, 
som att tillåta CORS och att skicka rätt svarskoder vid anrop.