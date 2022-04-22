-- TREUST Nolwenn
-- ZALLOT Tristan
-- Groupe F12

set schema 'matski_update';

-- 1. Es-ce que certains articles ou catégories ne sont jamais commandés ? 
-- ARTICLES JAMAIS COMMANDES
select NUMARTICLE
from _ARTICLE
except 
select NUMARTICLE
from _DETAILCOMMANDE ; 

-- CATEGORIES JAMAIS COMMANDES
select NUMCATEGORIE
from _CATEGORIE
except ((
select NUMCATEGORIE
from _ARTICLE
where NUMARTICLE in (select NUMARTICLE
                     from _DETAILCOMMANDE) 
union 
select CAT_NUMCATEGORIE2
from _ARTICLE natural join _SE_DECOMPOSE
where NUMARTICLE in (select NUMARTICLE
                     from _DETAILCOMMANDE))
union
select CAT_NUMCATEGORIE2
from _SE_DECOMPOSE 
where  NUMCATEGORIE in (select CAT_NUMCATEGORIE2
from _ARTICLE natural join _SE_DECOMPOSE
where NUMARTICLE in (select NUMARTICLE
                     from _DETAILCOMMANDE)));  

-- 2. PAS A FAIRE 
                     
-- 3. Existe-t-il des client·es qui n'ont jamais passé de commande ?
-- CLIENTS QUI ONT PAS COMMANDE
select NUMCLIENT
from _CLIENT
except 
select NUMCLIENT
from _COMMANDE ; 

------------ 4. INCOMPLETE ----------------------
-- 4. Il  semble  que  certaines  commandes  ne  soient  pas  livrées  totalement. Le phénomène est-il inquiétant ? 
-- COMMANDES PAS LIVREES EN TOTALITE
select NUMCOMMANDE, QUANTITECOMMANDEE, QUANTITELIVREE
from _DETAILCOMMANDE
where QUANTITECOMMANDEE <> QUANTITELIVREE ;

-- 5.La/Le comptable de l'entreprise sollicite votre aide pour l'aider 
-- à remplir la déclaration de TVA pour le dernier mois et notamment 
-- la TVA collectée sur les ventes. En fonction des types de clients,
-- elle/il a besoin du montant des ventes correspondant à trois ventilations :

-- a) Vente à des clients en France

-- b) Vente à des clients étrangers hors UE

-- c) Vente à des clients étrangers dans UE